import 'dart:convert';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/data/json/device_icon.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class DeviceDetailsEditView extends StatefulWidget {
  const DeviceDetailsEditView({super.key});

  @override
  State<StatefulWidget> createState() => _DeviceDetailsEditView();
}

class _DeviceDetailsEditView extends State<DeviceDetailsEditView> {
  //设备名称
  final TextEditingController _controllerName = TextEditingController();

  //icon列表
  List<DeviceIcon> list = [];

  //当前选中项
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    _controllerName.value = TextEditingValue(
        text: context.deviceControllerRead.current?.name ?? "");
    if (context.deviceControllerRead.current != null &&
        context.deviceControllerRead.current!.icon.isNotEmpty) {
      setState(() {
        currentIndex =
            int.tryParse(context.deviceControllerRead.current!.icon);
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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(245, 246, 248, 1),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                width: 335.w,
                margin: EdgeInsets.fromLTRB(0, 15.w, 0, 0),
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
            Container(
              margin: EdgeInsets.all(15.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 50.w,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              context.localization.deiveName,
                              style: context.labelLarge,
                            )),
                      ),
                      Expanded(
                          child: TextField(
                        controller: _controllerName,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 15.sp),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: context.localization.deiveNameHint,
                          hintStyle: context.bodyMedium.copyWith(
                            color: context.bodyMedium.color!.withOpacity(0.6),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 50.w,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              context.localization.deviceSN,
                              style: context.labelLarge,
                            )),
                      ),
                      Text(context.deviceControllerRead.current?.deviceId ?? "",
                          style: context.labelLarge)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 335.w,
              height: 300.h,
              margin: EdgeInsets.all(15.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("设备图标",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromRGBO(102, 102, 102, 1))),
                  SizedBox(height: 10.h),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5, // 每行显示2个项
                            crossAxisSpacing: 10.w, // 项之间的水平间距
                            mainAxisSpacing: 10.h, // 项之间的垂直间距
                          ),
                          itemCount: list.length, // 总共项
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Container(
                                    color:
                                        const Color.fromRGBO(245, 246, 248, 1),
                                    padding: EdgeInsets.all(5.w),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              currentIndex == index
                                                  ? list[index].iconSelected
                                                  : list[index].icon),
                                          width: 25.w,
                                          height: 25.w,
                                        ),
                                        Text(list[index].name,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1)))
                                      ],
                                    )));
                          }))
                ],
              ),
            ),
            SizedBox(
              width: 335.w,
              child: Loading(
                future: () => _updateDevice(),
                child: Text(
                  context.localization.save,
                  style: context.titleMedium.copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
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

  //更新设备数据
  _updateDevice() async {
    bool result = await context.deviceControllerRead.updateDevice(
        name: _controllerName.text,
        icon: currentIndex != null ? currentIndex.toString() : "");
    if (result) {
      EasyLoading.showToast("保存成功");
    }
  }
}
