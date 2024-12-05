import 'package:flutter/material.dart';
import 'package:flutter_template/src/data/api.dart';
import 'package:flutter_template/src/data/json/alarm_param.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/data/json/historical_traces.dart';
import 'package:flutter_template/src/data/json/historical_traces_all.dart';
import 'package:flutter_template/src/data/json/last_data.dart';
import 'package:flutter_template/src/data/json/message.dart';

class DeviceController extends ChangeNotifier {
  DeviceController(this.context,this._devices, this._lastData);
  BuildContext context;
  //设备列表
  List<Device> _devices = [];
  //设备最后数据
  LastData? _lastData;
  //设备历史轨迹
  HistoricalTracesAll? _historicalTracesAll;

  ///我的设备列表
  List<Device> get devices => _devices.isNotEmpty
      ? _devices.where((element) => element.shareState.value == 0).toList()
      : [];

  ///分享的设备列表
  List<Device> get shareDevices => _devices.isNotEmpty
      ? _devices.where((element) => element.shareState.value != 0).toList()
      : [];

  ///当前观察的设备
  Device? get current => (_devices.isNotEmpty &&
          _devices.any((element) => element.defaultValue == 1))
      ? _devices.firstWhere((element) => element.defaultValue == 1)
      : null;

  ///是否存在观察设备
  bool get hasDevices => current != null;

  ///设备最后数据
  LastData? get lastData => _lastData;

  ///设备历史轨迹
  List<HistoricalTraces> get historicalTraces =>
      _historicalTracesAll?.items ?? [];

  ///是否有设备最后数据
  bool get hasLastData => _lastData != null;

  ///获取设备列表
  Future<void> loadDevices() async {
    if (await Api.instance.isTokenExpired()) {
      return;
    }
    final devices = await Api.instance.getDevices();
    if (devices != null) {
      _updateDevices(devices);
      await getLast();
    }
  }

  ///获取设备最后数据
  Future<void> getLast() async {
    if (current == null) {
      return;
    }
    final last = await Api.instance.getLast(current!.deviceId!);
    if (last != null && _lastData != last) {
      if(_lastData !=null && _lastData?.address !=null && _lastData?.longitude == last.longitude && _lastData?.latitude == last.latitude){
        String? address = lastData?.address;
        _lastData = last;
        _lastData?.setName(current?.name);
        _lastData?.setAddress(address);
      }else{
        _lastData = last;
        _lastData?.setName(current?.name);
        if(context.mounted){
          await _lastData?.getAddressAsync(context);
        }
      }
      notifyListeners();
    }

    if(last == null && _lastData != null){
      _lastData = last;
      notifyListeners();
    }
  }

  ///获取设备历史轨迹数据
  Future<bool> getHistoricalTraces(String beginDate, String endDate,
      List<int> locateModes, int stopTime) async {
    if (current == null) {
      return false;
    }
    final traces = await Api.instance.queryTrajectory(
        current!.deviceId!, beginDate, endDate, locateModes, stopTime);
    if (traces != null) {
      _historicalTracesAll = traces;
      notifyListeners();
      return true;
    }
    return false;
  }

  ///清除设备数据
  void clearDevices() {
    _lastData = null;
    _updateDevices([]);
  }

  ///更新设备
  void _updateDevices(List<Device> devices) {
    if(!devices.every((item)=>_devices.contains(item))){
      _devices = devices;
      notifyListeners();
    }
    if(devices.isEmpty && _devices.isNotEmpty){
      _devices = devices;
      notifyListeners();
    }
  }

  ///设置默认的观察设备
  Future<bool> setDefault(String deviceId) async {
    final devices = await Api.instance.setDefault(deviceId);
    if (devices == null) {
      return false;
    }
    _updateDevices(devices);
    await getLast();
    return true;
  }

  ///添加设备
  Future<bool> addDevice(String name, String deviceId) async {
    final devices = await Api.instance.addDevice(deviceId, name);
    if (devices == null) {
      return false;
    }
    _updateDevices(devices);
    return true;
  }

  ///更新当前设备数据
  Future<bool> updateDevice({String? name, String? deviceId, String? icon,int? traceMode}) async {
    traceMode = traceMode ?? current?.traceMode.value ?? 0;
    name = name ?? current?.name ?? "";
    deviceId = deviceId ?? current?.deviceId ?? "";
    icon = icon ?? current?.icon ?? "";
    final devices = await Api.instance.updateDevice(deviceId, name, icon, traceMode);
    if (devices == null) {
      return false;
    }
    _updateDevices(devices);
    return true;
  }

  ///解绑设备
  Future<bool> unbindDevice() async {
    if (current == null) {
      return false;
    }
    final devices = await Api.instance.unbindDevice(current!.deviceId!);
    if (devices == null) {
      return false;
    }
    _lastData = null;
    _updateDevices(devices);
    return true;
  }

  ///获取设备告警参数
  Future<List<AlarmParam>?> getAlarmParams() async {
    if (current == null) {
      return [];
    }
    return await Api.instance.getAlarmParams(current!.deviceId!);
  }

  ///更新设备告警参数
  Future<List<AlarmParam>?> updateAlarmParams(List<AlarmParam> params) async {
    if (current == null) {
      return [];
    }
    return await Api.instance.updateAlarmParams(current!.deviceId!, params);
  }

  ///获取设备消息列表
  Future<List<Message>?> getMessages(bool desc) async {
    if (current == null) {
      return [];
    }
    final res = await Api.instance.getMessages(current!.deviceId!, desc);
    if (res == null) {
      return [];
    }
    return res;
  }

  ///标记设备消息为已读
  Future<void> readMessage(int messageId) async {
    if (current == null) {
      return;
    }
    await Api.instance.readMessage(current!.deviceId!, messageId);
  }
}
