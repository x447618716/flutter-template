import 'package:flutter_template/src/data/json/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  Device(
      this.userId,
      this.deviceId,
      this.defaultValue,
      this.name,
      this.icon,
      this.remark,
      this.deviceType,
      this.sim,
      this.iccId,
      this.traceMode,
      this.changed,
      this.createTime,
      this.updateTime,
      this.id,
      this.isDefault,
      this.onlineStatus,
      this.shareState);

  ///用户id
  int userId;

  ///设备编号
  String? deviceId;

  ///是否默认设备，1 表示为默认设备；0 表示非默认设备；
  int defaultValue;

  ///设备名称：车牌号或其它
  String? name;

  ///设备图标
  String icon;

  ///备注
  String? remark;

  ///设备型号信息
  String? deviceType;

  ///SIM卡号
  String? sim;

  ///ICC ID
  @JsonKey(name: 'iccid')
  String? iccId;

  ///轨迹模式
  Status traceMode;

  ///绑定变更记录
  String? changed;

  ///记录创建时间
  String createTime;

  ///记录最后更新时间
  String updateTime;

  ///id
  int id;

  ///是否为默认设备：TRUE 表示默认设备；FALSE 表示非默认设备；
  bool? isDefault;

  ///设备在线状态
  Status onlineStatus;

  ///设备分享状态
  Status shareState;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Device otherDevice = other as Device;
    return otherDevice.userId == userId &&
        otherDevice.deviceId == deviceId &&
        otherDevice.defaultValue == defaultValue &&
        otherDevice.name == name &&
        otherDevice.icon == icon &&
        otherDevice.remark == remark &&
        otherDevice.deviceType == deviceType &&
        otherDevice.sim == sim &&
        otherDevice.traceMode == traceMode &&
        otherDevice.id == id &&
        otherDevice.changed == changed &&
        otherDevice.createTime == createTime &&
        otherDevice.iccId == iccId &&
        otherDevice.isDefault == isDefault &&
        otherDevice.onlineStatus == onlineStatus &&
        otherDevice.shareState == shareState;
  }

  @override
  int get hashCode {
    return Object.hash(
        userId,
        deviceId,
        defaultValue,
        name,
        icon,
        remark,
        deviceType,
        sim,
        traceMode,
        id,
        changed,
        createTime,
        iccId,
        isDefault,
        onlineStatus,
        shareState,
        updateTime);
  }
}
