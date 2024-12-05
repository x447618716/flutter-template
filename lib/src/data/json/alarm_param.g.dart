// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmParam _$AlarmParamFromJson(Map<String, dynamic> json) => AlarmParam(
      json['name'] as String,
      json['value'] as bool,
      (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$AlarmParamToJson(AlarmParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'type': instance.type,
    };
