import 'package:json_annotation/json_annotation.dart';
part 'status.g.dart';

@JsonSerializable()
class Status {
  Status(this.name, this.value);

  ///状态值
  int value;
  ///状态名
  String name;

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Status otherStatus = other as Status;
    return otherStatus.value == value &&
        otherStatus.name == name;
  }

  @override
  int get hashCode {
    return Object.hash(name, value);
  }
}
