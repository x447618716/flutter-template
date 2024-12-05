// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      json['access_token'] as String,
      json['refresh_token'] as String,
      (json['expires_in'] as num).toInt(),
    )..expireDate = json['expireDate'] == null
        ? null
        : DateTime.parse(json['expireDate'] as String);

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'expireDate': instance.expireDate?.toIso8601String(),
    };
