import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate;
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/data/json/historical_traces.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/location/location_controller.dart';

class HistoryTraceNextView extends StatefulWidget {
  const HistoryTraceNextView({super.key});



  @override
  State<HistoryTraceNextView> createState() => _HistoryTraceNextViewState();
}

class _HistoryTraceNextViewState extends State<HistoryTraceNextView> {
  LocationController? _locationController;
  late BMFMapController mapController;
  ElTooltipController controller = ElTooltipController();
  //坐标点集合
  late List<BMFCoordinate> position;
  //动态轨迹控制器
  BMFTraceOverlay? _traceOverlay;
  //是否播放
  bool play = false;
  //进度
  double progress = 0;
  //速率
  late double duration;

  String time = "";
  String speed = "1";

  late HistoricalTraces? Function(double progress)  progressEvent;

  @override
  void initState() {
    super.initState();
    position = context.deviceControllerRead.historicalTraces
        .map((e) => BMFCoordinate(e.latitude, e.longitude))
        .toList();
    duration = position.length / 3;
    progressEvent = getProgressData();
  }

  @override
  void dispose() {
    if (_traceOverlay != null) {
      _traceOverlay?.pauseTraceOverlayDraw();
      mapController.removeTraceOverlay(_traceOverlay!.id);
    }
    controller.hide();
    super.dispose();
  }

  //暂停与开始
  void playAndPause() async {
    if (play) {
      _traceOverlay?.pauseTraceOverlayDraw();
      setState(() {
        play = false;
      });
    } else {
      if (progress == 1) {
        setState(() {
          progress = 0;
        });
        progressEvent = getProgressData();
        if (await mapController.removeTraceOverlay(_traceOverlay!.id)) {
          _traceOverlay = await _locationController?.drawDynamicTrajectories(
              position, duration);
        }
      } else {
        if (_traceOverlay != null) {
          _traceOverlay?.resumeTraceOverlayDraw();
          setState(() {
            play = true;
          });
        } else {
          if (position.isNotEmpty) {
            progressEvent = getProgressData();
            //绘制动态轨迹
            _traceOverlay = await _locationController?.drawDynamicTrajectories(
                position, duration);
          }
        }
      }
    }
  }

  //设置速度
  void setSpeed(int num) async {
    if (_traceOverlay != null) {
      setState(() {
        progress = 0;
        play = true;
        speed = num.toString();
      });
      progressEvent = getProgressData();
      _traceOverlay?.pauseTraceOverlayDraw();
      if (await mapController.removeTraceOverlay(_traceOverlay!.id)) {
        _traceOverlay = await _locationController?.drawDynamicTrajectories(
            position, duration / num);
      }
    }
    controller.hide();
  }

  HistoricalTraces? Function(double progress) getProgressData() {
    int num = 0;
    int temp = 0;
    if (context.deviceControllerRead.historicalTraces.length > 100) {
      int itemLength = context.deviceControllerRead.historicalTraces.length ~/ 100;
      return (double progress) {
        HistoricalTraces? data;
        if(num == progress.toInt()){
          data = context.deviceControllerRead.historicalTraces[itemLength*num+temp];
        }else{
          num = progress.toInt();
          temp = 0;
        }
        if(temp<itemLength){
          temp ++;
        }
        return data;
      };
    } else {
      return (double progress) {
        HistoricalTraces? data;
        if(temp<context.deviceControllerRead.historicalTraces.length){
          data = context.deviceControllerRead.historicalTraces[temp];
          temp ++;
        }else{
          data = context.deviceControllerRead.historicalTraces[context.deviceControllerRead.historicalTraces.length];
        }
        return data;
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.historyTrace,
      ),
      body: Stack(
        children: [
          MapWidget(
            center: position.isEmpty ? null : position[0],
            zoomLevel: 18,
            zoomEnabled: false,
            onMapCreated: (controller) async {
              _locationController =
                  LocationController(mapController: controller);
              mapController = controller.mapController;

              /// 设置traceOverlay动画开始回调
              mapController
                  .setTraceOverlayAnimationDidStartCallback((traceOverlay) {
                setState(() {
                  play = true;
                });
              });

              /// 设置traceOverlay动画进度回调
              mapController.setTraceOverlayAnimationRunningProgressCallback(
                  (traceOverlay, progress2) async {
                setState(() {
                  progress = progress2 / 100;
                  time = progressEvent(progress2)?.receivedTime ?? "";
                });
                if (progress2 == 99) {
                  //暂停动画
                  _traceOverlay?.pauseTraceOverlayDraw();
                  setState(() {
                    progress = 1;
                    play = false;
                  });
                }
              });

              if (position.isNotEmpty) {
                //绘制动态轨迹
                _traceOverlay = await _locationController
                    ?.drawDynamicTrajectories(position, duration);
              }
            },
          ),
          if (position.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PhysicalModel(
                color: context.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
                elevation: 1.0,
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context.deviceControllerWatch.current!.name!,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        const Color.fromRGBO(61, 61, 61, 1))),
                            Text(time,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(61, 61, 61, 1)))
                          ]),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                              child: Row(children: [
                            Text("定位时长",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1))),
                            SizedBox(width: 10.w),
                            Text("--",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(51, 51, 51, 1)))
                          ])),
                          Expanded(
                              child: Row(
                            children: [
                              Text("速度",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              SizedBox(width: 10.w),
                              Text("0km/h",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1)))
                            ],
                          ))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Text("停留时长",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              SizedBox(width: 10.w),
                              Text("--",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1)))
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Text("当前里程",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              SizedBox(width: 10.w),
                              Text("0km",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1)))
                            ],
                          ))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Image.asset("assets/images/location.png",
                              width: 18.w, height: 20.w),
                          SizedBox(width: 5.w),
                          Expanded(
                              child: Text(
                                  context.deviceControllerWatch.lastData?.address ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                            height: 30.w,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 30.w,
                                onPressed: () => playAndPause(),
                                color: Colors.blueAccent,
                                icon: Icon(play
                                    ? Icons.pause_circle
                                    : Icons.play_circle)),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: LinearProgressIndicator(
                                  minHeight: 20.0,
                                  borderRadius: BorderRadius.circular(10.0),
                                  value: progress)),
                          SizedBox(width: 10.w),
                          ElTooltip(
                              position: ElTooltipPosition.topEnd,
                              controller: controller,
                              padding: EdgeInsets.zero,
                              color: Colors.black12,
                              content: SizedBox(
                                width: 70.w,
                                height: 150.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () => setSpeed(1),
                                        style: const ButtonStyle(
                                            padding: WidgetStatePropertyAll<
                                                EdgeInsets>(EdgeInsets.zero)),
                                        child: Text("x1",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.blueAccent))),
                                    TextButton(
                                        onPressed: () => setSpeed(2),
                                        style: const ButtonStyle(
                                            padding: WidgetStatePropertyAll<
                                                EdgeInsets>(EdgeInsets.zero)),
                                        child: Text("x2",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.blueAccent))),
                                    TextButton(
                                        onPressed: () => setSpeed(3),
                                        style: const ButtonStyle(
                                            padding: WidgetStatePropertyAll<
                                                EdgeInsets>(EdgeInsets.zero)),
                                        child: Text("x3",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.blueAccent)))
                                  ],
                                ),
                              ),
                              child: Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Text("x$speed",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white)))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
