// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      (json['id'] as num).toInt(),
      Status.fromJson(json['eventType'] as Map<String, dynamic>),
      json['deviceName'] as String,
      json['deviceId'] as String,
      json['time'] as String,
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      json['isRead'] as bool,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'eventType': instance.eventType,
      'deviceName': instance.deviceName,
      'deviceId': instance.deviceId,
      'time': instance.time,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'isRead': instance.isRead,
    };
