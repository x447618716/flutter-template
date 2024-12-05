import 'package:json_annotation/json_annotation.dart';
part 'login_error.g.dart';

@JsonSerializable()
class LoginError {
  LoginError(this.error, this.errorDescription);
  String error;
  @JsonKey(name: 'error_description')
  String errorDescription;

  factory LoginError.fromJson(Map<String, dynamic> json) =>
      _$LoginErrorFromJson(json);

  Map<String, dynamic> toJson() => _$LoginErrorToJson(this);
}
