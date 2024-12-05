// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      (json['userId'] as num).toInt(),
      json['deviceId'] as String?,
      (json['defaultValue'] as num).toInt(),
      json['name'] as String?,
      json['icon'] as String,
      json['remark'] as String?,
      json['deviceType'] as String?,
      json['sim'] as String?,
      json['iccid'] as String?,
      Status.fromJson(json['traceMode'] as Map<String, dynamic>),
      json['changed'] as String?,
      json['createTime'] as String,
      json['updateTime'] as String,
      (json['id'] as num).toInt(),
      json['isDefault'] as bool?,
      Status.fromJson(json['onlineStatus'] as Map<String, dynamic>),
      Status.fromJson(json['shareState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'userId': instance.userId,
      'deviceId': instance.deviceId,
      'defaultValue': instance.defaultValue,
      'name': instance.name,
      'icon': instance.icon,
      'remark': instance.remark,
      'deviceType': instance.deviceType,
      'sim': instance.sim,
      'iccid': instance.iccId,
      'traceMode': instance.traceMode.toJson(),
      'changed': instance.changed,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'isDefault': instance.isDefault,
      'onlineStatus': instance.onlineStatus.toJson(),
      'shareState': instance.shareState.toJson(),
    };
