import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/data/enums.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';

class QueryPanel extends StatefulWidget {
  const QueryPanel({super.key});


  @override
  State<QueryPanel> createState() => _QueryPanelState();
}

class _QueryPanelState extends State<QueryPanel> {
  int _selectedIndex = 0;
  //定位模式
  final List<int> mode = [LocateMode.gps.index];

  //默认选中时间(日历)
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  //小时
  final TextEditingController _controllerHour = TextEditingController();
  //分钟
  final TextEditingController _controllerMin = TextEditingController();

  //弹窗类型 0：开始时间  1：结束时间
  int _type = 0;
  //时间范围是否正确
  bool correctTimeRange = true;

  //开始时间
  String startTime =
      Jiffy.now().startOf(Unit.day).format(pattern: 'yyyy-MM-dd HH:mm');

  //结束时间
  String endTime =
      Jiffy.now().endOf(Unit.day).format(pattern: 'yyyy-MM-dd HH:mm');

  //过滤停车时长
  String _filterParkingDuration = "0";

  Widget _buildSegment(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
      child: Text(
        context.localization.fastSelect(index),
        style: _selectedIndex == index
            ? context.labelLarge.copyWith(color: context.primaryColor)
            : context.labelLarge.copyWith(color: context.secondaryColor),
      ),
    );
  }

  Widget _buildLocateMode(LocateMode value) {
    return InkWell(
      onTap: () => locateModeChoose(value),
      child: Row(
        children: [
          SizedBox(
              width: 30.0,
              height: 30.0,
              child: Checkbox(
                  value: mode.contains(value.index),
                  onChanged: (bool? v) => locateModeChoose(value))),
          Text(context.localization.locateModeName(value.index),
              style: context.labelLarge.copyWith(color: context.secondaryColor))
        ],
      ),
    );
  }

  //显示时间弹窗
  _showDateDialog(int type) {
    _type = type;
    _focusedDay.value =
        type == 0 ? DateTime.parse(startTime) : DateTime.parse(endTime);
    _controllerHour.text = type == 0
        ? DateTime.parse(startTime).hour.toString().padLeft(2, "0")
        : DateTime.parse(endTime).hour.toString().padLeft(2, "0");
    _controllerMin.text = type == 0
        ? DateTime.parse(startTime).minute.toString().padLeft(2, "0")
        : DateTime.parse(endTime).minute.toString().padLeft(2, "0");
    showDialog(
        context: context,
        builder: (BuildContext context) => ValueListenableBuilder(
            valueListenable: _focusedDay,
            builder: (_, DateTime date, __) {
              return Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TableCalendar(
                            locale: 'zh_CN',
                            firstDay: DateTime.utc(2024, 1, 16),
                            lastDay: DateTime.utc(2100, 3, 14),
                            focusedDay: date,
                            currentDay: type == 0
                                ? DateTime.parse(startTime)
                                : DateTime.parse(endTime),
                            daysOfWeekVisible: false,
                            headerStyle: const HeaderStyle(titleCentered: true),
                            calendarFormat: CalendarFormat.month,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month'
                            },
                            selectedDayPredicate: (day) {
                              return isSameDay(_focusedDay.value, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(_focusedDay.value, selectedDay)) {
                                _focusedDay.value = selectedDay;
                              }
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 40.w,
                                          height: 40.w,
                                          alignment: Alignment.center,
                                          child: TextField(
                                              controller: _controllerHour,
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 15.sp),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: '00',
                                                counterText: "",
                                                contentPadding: EdgeInsets.zero,
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1)),
                                              ))),
                                      Center(
                                          child: Text(":",
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  color: const Color.fromRGBO(
                                                      153, 153, 153, 1)))),
                                      Container(
                                          width: 40.w,
                                          height: 40.w,
                                          alignment: Alignment.center,
                                          child: TextField(
                                            controller: _controllerMin,
                                            maxLength: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15.sp),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: '00',
                                              counterText: "",
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      153, 153, 153, 1)),
                                            ),
                                          ))
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Center(
                                      child: SizedBox(
                                    width: 300.w,
                                    child: Loading(
                                      padding: EdgeInsets.all(10.w),
                                      future: () => confirmDate(),
                                      child: Text(
                                        context.localization.confirm,
                                        style: context.titleMedium.copyWith(
                                          color: context.onPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ))
                        ],
                      ))
                ],
              );
            }));
  }

  //时间确认
  Future<void> confirmDate() async {
    Jiffy time = Jiffy.parse(_focusedDay.value.toString())
        .startOf(Unit.day)
        .add(
            hours: int.tryParse(_controllerHour.text) ?? 0,
            minutes: int.tryParse(_controllerMin.text) ?? 0);
    if (_type == 0) {
      setState(() {
        startTime = time.format(pattern: 'yyyy-MM-dd HH:mm');
        correctTimeRange = true;
      });
    } else {
      setState(() {
        endTime = time.format(pattern: 'yyyy-MM-dd HH:mm');
      });
    }
    Navigator.of(context).pop();
  }

  //确认查询
  Future<void> confirmSearch() async {
    if(!correctTimeRange){
      return;
    }
    if (Jiffy.parse(startTime).isAfter(Jiffy.parse(endTime))) {
      EasyLoading.showToast(context.localization.timeOnTip);
      setState(() {
        correctTimeRange = false;
      });
      return;
    }

    bool temp = await context.deviceControllerRead.getHistoricalTraces(startTime, endTime,mode.map((item)=>item+1).toList(),int.tryParse(_filterParkingDuration) ?? 0);
    if (temp && mounted) {
      HistoryTraceNextRoute().go(context);
    }
  }

  //分组时间选择
  void groupTimeChoose(index) {
    if (index == null) {
      return;
    }
    switch (index) {
      case 0:
        setState(() {
          startTime =
              Jiffy.now().startOf(Unit.day).format(pattern: 'yyyy-MM-dd HH:mm');
          endTime =
              Jiffy.now().endOf(Unit.day).format(pattern: 'yyyy-MM-dd HH:mm');
          _selectedIndex = index;
        });
        break;
      case 1:
        setState(() {
          startTime = Jiffy.now()
              .subtract(days: 1)
              .startOf(Unit.day)
              .format(pattern: 'yyyy-MM-dd HH:mm');
          endTime = Jiffy.now()
              .subtract(days: 1)
              .endOf(Unit.day)
              .format(pattern: 'yyyy-MM-dd HH:mm');
          _selectedIndex = index;
        });
        break;
      case 2:
        setState(() {
          startTime = Jiffy.now()
              .subtract(days: 2)
              .startOf(Unit.day)
              .format(pattern: 'yyyy-MM-dd HH:mm');
          endTime = Jiffy.now()
              .subtract(days: 2)
              .endOf(Unit.day)
              .format(pattern: 'yyyy-MM-dd HH:mm');
          _selectedIndex = index;
        });
        break;
      case 3:
        setState(() {
          _selectedIndex = index;
        });
        break;
    }
  }

  //定位模式选择
  void locateModeChoose(LocateMode value) {
    if (mode.contains(value.index)) {
      if (mode.length == 1) {
        EasyLoading.showToast(context.localization.modeTips);
      } else {
        mode.remove(value.index);
      }
    } else {
      mode.add(value.index);
    }
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();

    _controllerHour.addListener(() {
      final int value = int.tryParse(_controllerHour.text) ?? 0;
      if (value > 23) {
        _controllerHour.value = TextEditingValue(
          text: '23',
          selection:
              TextSelection.collapsed(offset: _controllerHour.text.length),
        );
      }
    });

    _controllerMin.addListener(() {
      final int value = int.tryParse(_controllerMin.text) ?? 0;
      if (value > 59) {
        _controllerMin.value = TextEditingValue(
          text: '59',
          selection:
              TextSelection.collapsed(offset: _controllerMin.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.backgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl(
                thumbColor: context.onPrimaryColor,
                groupValue: _selectedIndex,
                children: {
                  0: _buildSegment(0),
                  1: _buildSegment(1),
                  2: _buildSegment(2),
                  3: _buildSegment(3),
                },
                onValueChanged: (value) => groupTimeChoose(value)),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLocateMode(LocateMode.gps),
                _buildLocateMode(LocateMode.wifi),
                _buildLocateMode(LocateMode.lbs)
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.only(top: 3.w, bottom: 3.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(context.localization.startTime,
                          style: context.labelLarge
                              .copyWith(color: context.secondaryColor)),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => _showDateDialog(0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                correctTimeRange
                                    ? startTime
                                    : context.localization.timeChooseTip,
                                style: context.labelLarge),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: const Color.fromRGBO(231, 231, 231, 1),
                            size: 13.sp,
                          )
                        ],
                      ),
                    ))
                  ],
                )),
            SizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.only(top: 3.w, bottom: 3.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(context.localization.endTime,
                          style: context.labelLarge
                              .copyWith(color: context.secondaryColor)),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => _showDateDialog(1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(endTime, style: context.labelLarge),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: const Color.fromRGBO(231, 231, 231, 1),
                            size: 13.sp,
                          )
                        ],
                      ),
                    ))
                  ],
                )),
            SizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.only(top: 3.w, bottom: 3.w),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      context.localization.filterDuration,
                      style: context.labelLarge
                          .copyWith(color: context.secondaryColor),
                    )),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        // 背景色
                        borderRadius: BorderRadius.circular(16.0), // 圆角大小
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 15.sp),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: '0',
                          contentPadding: EdgeInsets.only(
                              left: 10.w, bottom: 10.w), // TextField 内容填充
                          border: InputBorder.none, // 移除 TextField 默认的边框
                        ),
                        onChanged: (text) {
                          _filterParkingDuration = text;
                        },
                      ),
                    ))
                  ],
                )),
            SizedBox(height: 10.h),
            Loading(
              padding: EdgeInsets.all(10.w),
              future: () => confirmSearch(),
              child: Text(
                context.localization.query,
                style: context.titleMedium.copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
