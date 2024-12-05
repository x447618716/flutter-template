import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate;
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/data/json/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'last_data.g.dart';

@JsonSerializable(explicitToJson: true)
class LastData {
  LastData(
    this.deviceId,
    this.deviceStatus,
    this.lastAliveTime,
    this.duration,
    this.latitude,
    this.longitude,
    this.drivingStatus,
    this.locationStatus,
    this.locateMode,
    this.traceMode,
    this.onlineStatus,
    this.speed,
    this.battery,
    this.mileage,
    this.locatedTime,
    this.receivedTime,
    this.signal,
    this.gpsSignal,
    this.alarmTextList,
  );

  ///设备编号
  String deviceId;

  ///设备状态(0:睡眠 1:关机 2:开机 )
  Status deviceStatus;

  ///设备最后活动时间
  String lastAliveTime;

  ///行驶状态持续时长
  String? duration;

  ///纬度
  @JsonKey(name: 'lat')
  double latitude;

  ///经度
  @JsonKey(name: 'lng')
  double longitude;

  ///行驶状态（0:静止 1: 运行）
  Status drivingStatus;

  ///定位状态（0:未定位 1:已定位）
  Status locationStatus;

  ///定位方式(0:未知 1：WIFI定位 2：GPS定位 3：基站定位)
  Status locateMode;

  ///轨迹模式(0:睡眠 1:打点 2:普通 3:追踪 )
  Status traceMode;

  ///在线状态
  Status onlineStatus;

  ///速度(km/h)
  int speed;

  ///剩余电量百分比
  int battery;

  ///累计里程: KM
  double mileage;

  ///定位时间
  String locatedTime;

  ///数据接收时间
  String receivedTime;

  ///设备通讯信号强度(0:强 1:中 2:弱)
  Status signal;

  ///设备卫星信号强度(0:强 1:中 2:弱)
  Status gpsSignal;

  ///报警名称列表
  List<String> alarmTextList = [];
  String? _name;
  String? _address;

  ///设备名称
  String? get name => _name;
  void setName(String? value) {
    _name = value;
  }

  ///设备所在位置
  String? get address => _address;

  Future<void> getAddressAsync(BuildContext context) async {
    _address = await MapWidgetController.getAddress(context, coordinate);
  }

  void setAddress(String? value) {
    _address = value;
  }

  BMFCoordinate get coordinate => BMFCoordinate(latitude, longitude);

  factory LastData.fromJson(Map<String, dynamic> json) =>
      _$LastDataFromJson(json);

  Map<String, dynamic> toJson() => _$LastDataToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final LastData otherLastData = other as LastData;
    if (otherLastData.alarmTextList.length != other.alarmTextList.length) return false;
    for (int i = 0; i < alarmTextList.length; i++) {
      if (alarmTextList[i] != otherLastData.alarmTextList[i]) return false;
    }
    return otherLastData.deviceId == deviceId &&
        otherLastData.onlineStatus == onlineStatus &&
        otherLastData.traceMode == traceMode &&
        otherLastData.latitude == latitude &&
        otherLastData.longitude == longitude &&
        otherLastData.duration == duration &&
        otherLastData.locatedTime == locatedTime &&
        otherLastData.lastAliveTime == lastAliveTime &&
        otherLastData.receivedTime == receivedTime &&
        otherLastData.battery == battery &&
        otherLastData.deviceStatus == deviceStatus &&
        otherLastData.drivingStatus == drivingStatus &&
        otherLastData.gpsSignal == gpsSignal &&
        otherLastData.locateMode == locateMode &&
        otherLastData.locationStatus == locationStatus &&
        otherLastData.mileage == mileage &&
        otherLastData.signal == signal &&
        otherLastData.speed == speed;
  }

  @override
  int get hashCode {
    return Object.hash(
        deviceId,
        onlineStatus,
        traceMode,
        latitude,
        longitude,
        duration,
        locatedTime,
        lastAliveTime,
        receivedTime,
        battery,
        deviceStatus,
        drivingStatus,
        gpsSignal,
        locateMode,
        locationStatus,
        mileage,
        signal,
        speed,
        alarmTextList);
  }
}
