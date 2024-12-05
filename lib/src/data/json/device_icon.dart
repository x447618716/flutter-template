import 'package:json_annotation/json_annotation.dart';
part 'device_icon.g.dart';

@JsonSerializable()
class DeviceIcon {
  DeviceIcon(this.name, this.icon, this.iconSelected);

  ///图标名称
  String name;

  ///未选中
  String icon;

  ///已选中
  String iconSelected;

  factory DeviceIcon.fromJson(Map<String, dynamic> json) =>
      _$DeviceIconFromJson(json);

  Map<String, dynamic> toJson(instance) => _$DeviceIconToJson(this);
}
