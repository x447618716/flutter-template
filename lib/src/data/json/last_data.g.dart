// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastData _$LastDataFromJson(Map<String, dynamic> json) => LastData(
      json['deviceId'] as String,
      Status.fromJson(json['deviceStatus'] as Map<String, dynamic>),
      json['lastAliveTime'] as String,
      json['duration'] as String?,
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      Status.fromJson(json['drivingStatus'] as Map<String, dynamic>),
      Status.fromJson(json['locationStatus'] as Map<String, dynamic>),
      Status.fromJson(json['locateMode'] as Map<String, dynamic>),
      Status.fromJson(json['traceMode'] as Map<String, dynamic>),
      Status.fromJson(json['onlineStatus'] as Map<String, dynamic>),
      (json['speed'] as num).toInt(),
      (json['battery'] as num).toInt(),
      (json['mileage'] as num).toDouble(),
      json['locatedTime'] as String,
      json['receivedTime'] as String,
      Status.fromJson(json['signal'] as Map<String, dynamic>),
      Status.fromJson(json['gpsSignal'] as Map<String, dynamic>),
      (json['alarmTextList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LastDataToJson(LastData instance) => <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceStatus': instance.deviceStatus.toJson(),
      'lastAliveTime': instance.lastAliveTime,
      'duration': instance.duration,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'drivingStatus': instance.drivingStatus.toJson(),
      'locationStatus': instance.locationStatus.toJson(),
      'locateMode': instance.locateMode.toJson(),
      'traceMode': instance.traceMode.toJson(),
      'onlineStatus': instance.onlineStatus.toJson(),
      'speed': instance.speed,
      'battery': instance.battery,
      'mileage': instance.mileage,
      'locatedTime': instance.locatedTime,
      'receivedTime': instance.receivedTime,
      'signal': instance.signal.toJson(),
      'gpsSignal': instance.gpsSignal.toJson(),
      'alarmTextList': instance.alarmTextList,
    };
