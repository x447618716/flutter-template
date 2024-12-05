enum DeviceStatus { online, offline, unknown }

enum ShareState { owner, onConfirm, onShare, offShare }

// 0: 无轨迹  1: 打点模式  2: 轨迹模式  3: 追踪模式
enum TraceMode { none, point, trace, track }

// 0: gps  1: wifi  2: lbs
enum LocateMode { gps, wifi, lbs }
