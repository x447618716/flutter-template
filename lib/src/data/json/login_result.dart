import 'package:json_annotation/json_annotation.dart';
part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  LoginResult(this.accessToken, this.refreshToken, this.expiresIn);

  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;

  DateTime? expireDate;

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    final data = _$LoginResultFromJson(json);
    data.expireDate ??=
        DateTime.now().add(Duration(seconds: (data.expiresIn - 300)));
    return data;
  }

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
