import 'package:json_annotation/json_annotation.dart';

import 'historical_traces.dart';

part 'historical_traces_all.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoricalTracesAll {
  HistoricalTracesAll(
    this.items,
    this.stopTime,
    this.stopTimeText,
    this.mileage,
  );

  List<HistoricalTraces>? items;
  int stopTime;
  String? stopTimeText;
  double mileage;

  factory HistoricalTracesAll.fromJson(Map<String, dynamic> json) =>
      _$HistoricalTracesAllFromJson(json);
  Map<String, dynamic> toJson(instance) => _$HistoricalTracesAllToJson(this);
}
