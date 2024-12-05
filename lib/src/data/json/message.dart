import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate;
import 'package:flutter_template/src/data/json/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  Message(
    this.id,
    this.eventType,
    this.deviceName,
    this.deviceId,
    this.time,
    this.latitude,
    this.longitude,
    this.isRead,
  );

  ///消息记录ID
  int id;

  ///事件类型
  Status eventType;

  ///设备名称
  String deviceName;

  ///设备编号
  String deviceId;

  ///消息触发时间
  String time;

  ///纬度
  @JsonKey(name: 'lat')
  double latitude;

  ///经度
  @JsonKey(name: 'lng')
  double longitude;

  ///消息读取状态: TRUE 表示已读；FALSE 表示未读；
  bool isRead;

  ///所在地址
  String _address = '';

  String get address => _address;
  void setAddress(String value) {
    _address = value;
  }

  void setRead(bool value) {
    isRead = value;
  }

  BMFCoordinate get coordinate => BMFCoordinate(latitude, longitude);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
