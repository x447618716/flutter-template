// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_traces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalTraces _$HistoricalTracesFromJson(Map<String, dynamic> json) =>
    HistoricalTraces(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      json['locatedTime'] as String,
      json['receivedTime'] as String,
      (json['speed'] as num).toInt(),
      (json['battery'] as num).toInt(),
      Status.fromJson(json['locationStatus'] as Map<String, dynamic>),
      Status.fromJson(json['locateMode'] as Map<String, dynamic>),
      (json['alarmTextList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HistoricalTracesToJson(HistoricalTraces instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitude,
      'locatedTime': instance.locatedTime,
      'receivedTime': instance.receivedTime,
      'speed': instance.speed,
      'battery': instance.battery,
      'locationStatus': instance.locationStatus.toJson(),
      'locateMode': instance.locateMode.toJson(),
      'alarmTextList': instance.alarmTextList,
    };
