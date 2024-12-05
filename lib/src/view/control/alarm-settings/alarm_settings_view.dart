import 'package:flutter/cupertino.dart' show CupertinoSwitch, CupertinoColors;
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class AlarmSettingsView extends StatefulWidget {
  const AlarmSettingsView({super.key});

  @override
  State<StatefulWidget> createState() => _AlarmSettingsViewState();
}

class _AlarmSettingsViewState extends State<AlarmSettingsView> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.alarmSettings,
      ),
      body: Container(
          color: const Color.fromRGBO(245, 246, 248, 1),
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.w, bottom: 20.w),
            margin: EdgeInsets.all(20.w),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.0)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("快捷设置",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                 const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("进圆形围栏报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("出圆形围栏报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("声控报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("低电量报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("信号弱报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("震动报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("超速报警",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      Padding(
                          padding: EdgeInsets.all(10.w),
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ],
            ),
          )),
    );
  }
}
