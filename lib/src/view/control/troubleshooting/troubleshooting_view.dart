import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:jiffy/jiffy.dart';

class TroubleshootingView extends StatefulWidget {
  const TroubleshootingView({super.key});

  @override
  State<StatefulWidget> createState() => _TroubleshootingViewState();
}

class _TroubleshootingViewState extends State<TroubleshootingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: context.localization.troubleshooting,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(245, 246, 248, 1),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10.w),
                    width: double.infinity,
                    height: 90.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(context.localization.selfCheckReport,
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromRGBO(61, 61, 61, 1)))),
                        Expanded(
                            child: Row(
                          children: [
                            Text(context.localization.dataTime,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1))),
                            SizedBox(width: 5.w),
                            Expanded(
                                child: Text(
                                    Jiffy.parse(DateTime.now().toString())
                                        .format(pattern: 'yyyy-MM-dd HH:MM'),
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1))))
                          ],
                        ))
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160.w,
                            color: Colors.white,
                            padding: EdgeInsets.all(15.w),
                            child: Row(
                              children: [
                                Image.asset('assets/images/333-1.png',
                                    width: 39.r, height: 39.r),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.deviceState,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1)),
                                    ),
                                    Text(
                                      "行驶",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Container(
                            width: 160.w,
                            color: Colors.white,
                            padding: EdgeInsets.all(15.w),
                            child: Row(
                              children: [
                                Image.asset('assets/images/333-2.png',
                                    width: 39.r, height: 39.r),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.netState,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1)),
                                    ),
                                    Text(
                                      "信号差",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160.w,
                            color: Colors.white,
                            padding: EdgeInsets.all(15.w),
                            child: Row(
                              children: [
                                Image.asset('assets/images/333-3.png',
                                    width: 39.r, height: 39.r),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.battery,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1)),
                                    ),
                                    Text(
                                      "100%",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Container(
                            width: 160.w,
                            color: Colors.white,
                            padding: EdgeInsets.all(15.w),
                            child: Row(
                              children: [
                                Image.asset('assets/images/333-4.png',
                                    width: 39.r, height: 39.r),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.satelliteSignal,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1)),
                                    ),
                                    Text(
                                      "暂无",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromRGBO(
                                              51, 51, 51, 1)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 335.w,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("配置信息",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(51, 51, 51, 1))),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("录音状态",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("--",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("录音时长",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("--",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("录音灵敏度",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("--",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("震动灵敏度",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("--",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("定位模式",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("--",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: 335.w,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("基本信息",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(51, 51, 51, 1))),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("设备号码",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("14163681294",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("ICCID",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("898604F92623C1119712",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w,
                              child: Text("设备类型",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1)))),
                          SizedBox(width: 10.w),
                          Text("EGO9W",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ));
  }
}
