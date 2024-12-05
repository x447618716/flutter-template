import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class ElectronicFenceEditView extends StatefulWidget {
  const ElectronicFenceEditView({super.key});

  @override
  State<StatefulWidget> createState() => _ElectronicFenceEditView();
}

class _ElectronicFenceEditView extends State<ElectronicFenceEditView> {
  //围栏名称
  String? _fenceName;
  //围栏类型 0：出 1：进
  int _fenceType = 0;

  //保存
  void save() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.fence,
      ),
      body: Stack(
        children: [
          MapWidget(
            onMapCreated: (controller) {},
          ),
          Positioned(
            bottom: 30.0,
            left: 30.0,
            right: 30.0,
            child: PhysicalModel(
              color: context.backgroundColor,
              borderRadius: BorderRadius.circular(15.r),
              elevation: 1.0,
              child: Container(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Text("围栏名称：",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(61, 61, 61, 1))),
                      Expanded(
                          child: TextField(
                        style: TextStyle(fontSize: 15.sp),
                        decoration: InputDecoration(
                          hintText: '请输入围栏名称',
                          contentPadding: EdgeInsets.fromLTRB(
                              5.w, 0, 5.w, 0), // TextField 内容填充
                          border: InputBorder.none, // 移除 TextField 默认的边框
                        ),
                        onChanged: (text) {
                          setState(() {
                            _fenceName = text;
                          });
                        },
                      ))
                    ]),
                    SizedBox(height: 10.h),
                    Row(children: [
                      Text("围栏名称：",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(61, 61, 61, 1))),
                      Container(
                        width: 30.w,
                        height: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _fenceType == 0
                                ? const Color.fromRGBO(0, 122, 255, 0.15)
                                : const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(7.r)),
                        child: TextButton(
                          onPressed: () {
                            if (_fenceType != 0) {
                              setState(() {
                                _fenceType = 0;
                              });
                            }
                          },
                          style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent)),
                          child: Text("出",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: _fenceType == 0
                                      ? const Color.fromRGBO(0, 122, 255, 1)
                                      : const Color.fromRGBO(
                                          102, 102, 102, 1))),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 30.w,
                        height: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _fenceType == 1
                                ? const Color.fromRGBO(0, 122, 255, 0.15)
                                : const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(7.r)),
                        child: TextButton(
                          onPressed: () {
                            if (_fenceType != 1) {
                              setState(() {
                                _fenceType = 1;
                              });
                            }
                          },
                          style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent)),
                          child: Text("进",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: _fenceType == 1
                                      ? const Color.fromRGBO(0, 122, 255, 1)
                                      : const Color.fromRGBO(
                                          102, 102, 102, 1))),
                        ),
                      )
                    ]),
                    Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () => {
                                if (_fenceName != null &&
                                    _fenceName!.isNotEmpty)
                                  {save()}
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: (_fenceName == null ||
                                          _fenceName!.isEmpty)
                                      ? const Color.fromRGBO(245, 246, 248, 1)
                                      : const Color.fromRGBO(0, 122, 255, 1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                    child: Text(
                                  context.localization.save,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: (_fenceName == null ||
                                              _fenceName!.isEmpty)
                                          ? const Color.fromRGBO(
                                              153, 153, 153, 1)
                                          : Colors.white),
                                )),
                              ),
                            ))
                          ],
                        ))
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
