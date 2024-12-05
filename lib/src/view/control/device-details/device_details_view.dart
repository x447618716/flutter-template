import 'dart:convert';

import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/data/json/device_icon.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class DeviceDetailsView extends StatefulWidget {
  const DeviceDetailsView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DeviceDetailsViewState();
}

class _DeviceDetailsViewState extends State<DeviceDetailsView> {
  //icon列表
  List<DeviceIcon> list = [];

  //当前选中项
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    if (context.deviceControllerRead.hasLastData) {
      if (context.deviceControllerRead.lastData?.address == null) {
        context.deviceControllerRead.lastData?.getAddressAsync(context);
      }
    }
    if (context.deviceControllerRead.current != null && context.deviceControllerRead.current!.icon.isNotEmpty) {
      setState(() {
        currentIndex =
            int.parse(context.deviceControllerRead.current!.icon);
      });
    }

    _loadIconData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.deviceDetail,
      ),
      body: Container(
          color: const Color.fromRGBO(245, 246, 248, 1),
          child: Center(
              child: Column(
            children: [
              Container(
                width: 335.w,
                margin: EdgeInsets.fromLTRB(0, 15.w, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset('assets/images/icon-600-0.png',
                            width: 25.r, height: 25.r),
                        SizedBox(width: 10.w),
                        Text("基本信息",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(61, 61, 61, 1)))
                      ],
                    )),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => DeviceDetailsEditRoute().go(context),
                      child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Image.asset('assets/images/icon-600-2.png',
                              width: 14.r, height: 14.r)),
                    )
                  ],
                ),
              ),
              Container(
                width: 335.w,
                margin: EdgeInsets.all(15.w),
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("设备名称",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(context.deviceControllerWatch.current?.name ?? "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("设备号码",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(
                            context.deviceControllerWatch.current?.deviceId ??
                                "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("设备类型",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(
                            context.deviceControllerWatch.current?.deviceType ??
                                "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("设备图标",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        iconNode()
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("备注信息",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Expanded(
                            child: Text(
                                context.deviceControllerWatch.current?.remark ??
                                    "",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1))))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 335.w,
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset('assets/images/icon-600-1.png',
                            width: 25.r, height: 25.r),
                        SizedBox(width: 10.w),
                        Text("定位信息",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(61, 61, 61, 1)))
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                width: 335.w,
                margin: EdgeInsets.all(15.w),
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("定位状态",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(
                            context.deviceControllerWatch.lastData
                                    ?.locationStatus.name ??
                                "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("定位时间",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(
                            context.deviceControllerWatch.lastData
                                    ?.locatedTime ??
                                "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("信号时间",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Text(
                            context.deviceControllerWatch.lastData
                                    ?.receivedTime ??
                                "",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1))),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 80.w,
                            child: Text("地址",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                        Expanded(
                            child: Text(
                                context.deviceControllerWatch.lastData
                                        ?.address ??
                                    "",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1)))),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ))),
    );
  }

  //加载图标数据
  Future<void> _loadIconData() async {
    Future<String> jsonString =
        DefaultAssetBundle.of(context).loadString('assets/device-icons.json');
    await jsonString.then((String value) {
      List iconList = json.decode(value);
      setState(() {
        list = iconList.map((item) => DeviceIcon.fromJson(item)).toList();
      });
    });
  }

  //图标节点
  Widget iconNode(){
    if (currentIndex != null && list.isNotEmpty){
      return Row(
        children: [
          Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0)),
              width: 30.r,
              height: 30.r,
              child: Image.asset(
                  list[currentIndex!].iconSelected)),
          SizedBox(width: 10.w),
          Text(
              list[currentIndex!].name,
              style: context.labelLarge
          )
        ],
      );
    }else{
      return const Text("");
    }
  }
}
