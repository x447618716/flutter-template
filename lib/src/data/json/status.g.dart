// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      json['name'] as String,
      (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };
