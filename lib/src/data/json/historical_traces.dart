import 'package:flutter_template/src/data/json/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'historical_traces.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoricalTraces {
  HistoricalTraces(
    this.latitude,
    this.longitude,
    this.locatedTime,
    this.receivedTime,
    this.speed,
    this.battery,
    this.locationStatus,
    this.locateMode,
    this.alarmTextList,
  );

  ///纬度
  @JsonKey(name: 'lat')
  double latitude;
  ///经度
  @JsonKey(name: 'lng')
  double longitude;
  ///定位时间
  String locatedTime;
  ///最后设备上报时间
  String receivedTime;
  ///速度(km/h)
  int speed;
  ///剩余电量百分比
  int battery;
  ///定位状态（0:未定位 1:已定位）
  Status locationStatus;
  ///定位方式(0:未知 1：WIFI定位 2：GPS定位 3：基站定位)
  Status locateMode;
  ///报警名称列表
  List<String> alarmTextList;

  factory HistoricalTraces.fromJson(Map<String, dynamic> json) =>
      _$HistoricalTracesFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalTracesToJson(this);
}
