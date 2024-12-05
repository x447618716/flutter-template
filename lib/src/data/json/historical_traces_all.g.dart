// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_traces_all.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalTracesAll _$HistoricalTracesAllFromJson(Map<String, dynamic> json) =>
    HistoricalTracesAll(
      (json['items'] as List<dynamic>?)
          ?.map((e) => HistoricalTraces.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['stopTime'] as num).toInt(),
      json['stopTimeText'] as String?,
      (json['mileage'] as num).toDouble(),
    );

Map<String, dynamic> _$HistoricalTracesAllToJson(
        HistoricalTracesAll instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'stopTime': instance.stopTime,
      'stopTimeText': instance.stopTimeText,
      'mileage': instance.mileage,
    };
