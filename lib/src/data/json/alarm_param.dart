import 'package:json_annotation/json_annotation.dart';
part 'alarm_param.g.dart';

@JsonSerializable()
class AlarmParam {
  AlarmParam(
    this.name,
    this.value,
    this.type,
  );

  String name;
  bool value;
  int type;

  factory AlarmParam.fromJson(Map<String, dynamic> json) =>
      _$AlarmParamFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmParamToJson(this);
}
