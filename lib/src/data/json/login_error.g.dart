// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginError _$LoginErrorFromJson(Map<String, dynamic> json) => LoginError(
      json['error'] as String,
      json['error_description'] as String,
    );

Map<String, dynamic> _$LoginErrorToJson(LoginError instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
