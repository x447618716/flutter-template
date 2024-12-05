import 'package:flutter/cupertino.dart'
    show
        showCupertinoModalPopup,
        CupertinoActionSheet,
        CupertinoActionSheetAction;
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/custom_dialog.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:jiffy/jiffy.dart';

class VoiceControlledAntiTheftView extends StatefulWidget {
  const VoiceControlledAntiTheftView({super.key});

  @override
  State<StatefulWidget> createState() => _VoiceControlledAntiTheftViewState();
}

class _VoiceControlledAntiTheftViewState
    extends State<VoiceControlledAntiTheftView> {
  //是否开始录音
  bool recordingBegins = false;
  //是否进行录音管理
  bool recordingManagement = false;

  String recordingText = "开始录音";

  String managementText = "管理";

  //录音提示弹窗
  void tipsDialog() {
    CustomDialog.confirm(
        context: context,
        content: Text("录音功能开启将会提高设备耗电量!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.sp,
                color: const Color.fromRGBO(153, 153, 153, 1))),
        confirmEvent: _showActionSheet);
  }

  //选中录音模式一
  void _showActionSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Padding(
            padding: EdgeInsets.all(10.w),
            child: Text("选择录音模式",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color.fromRGBO(168, 168, 168, 1)))),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showActionSheetTwo();
            },
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text('定时录音',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color.fromRGBO(22, 22, 22, 1)))),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showActionSheetTwo();
            },
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text('声控录音',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color.fromRGBO(22, 22, 22, 1)))),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("取消",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color.fromRGBO(22, 22, 22, 0.5)))),
        ),
      ),
    );
  }

  //选中录音模式二
  void _showActionSheetTwo() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Padding(
            padding: EdgeInsets.all(10.w),
            child: Text("选择录音模式",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color.fromRGBO(168, 168, 168, 1)))),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _recordingBegins();
            },
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text('定时录音1分钟',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color.fromRGBO(22, 22, 22, 1)))),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _recordingBegins();
            },
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text('声控录音2分钟',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color.fromRGBO(22, 22, 22, 1)))),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _recordingBegins();
            },
            child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text('声控录音3分钟',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color.fromRGBO(22, 22, 22, 1)))),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("取消",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color.fromRGBO(22, 22, 22, 0.5)))),
        ),
      ),
    );
  }

  //录音开始
  void _recordingBegins() {
    setState(() {
      recordingBegins = true;
      recordingText = "声控录音开启中...(点击关闭)";
    });
    EasyLoading.showToast("下发成功");
  }

  //录音结束
  void _recordingEed() {
    setState(() {
      recordingBegins = false;
      recordingText = "开始录音";
    });
    EasyLoading.showToast("关闭成功");
  }

  //录音管理
  void _recordingManagement() {
    setState(() {
      recordingManagement = true;
      managementText = "完成";
    });
  }

  //管理结束
  void _recordingManagementEnd() {
    setState(() {
      recordingManagement = false;
      managementText = "管理";
    });
  }

  final List<Map<String, dynamic>> _items = [
    {"id": 0, "name": "苹果"},
    {"id": 1, "name": "香蕉"},
    {"id": 2, "name": "橙子"},
    {"id": 3, "name": "葡萄"}
  ];
  List<int> _selections = [];
  bool _isAllSelected = false;

  void _handleItemChanged(int index) {
    setState(() {
      if (_selections.contains(_items[index]["id"])) {
        _selections.remove(_items[index]["id"]);
      } else {
        _selections.add(_items[index]["id"]);
      }

      _isAllSelected = _selections.length == _items.length;
    });
  }

  void _handleAllChanged() {
    setState(() {
      _isAllSelected = !_isAllSelected;
      if (_isAllSelected) {
        _selections = _items.map((item) => item["id"] as int).toList();
      } else {
        _selections = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.soundProtection,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: const Color.fromRGBO(245, 246, 248, 1),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Column(children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.w),
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Text(
                              Jiffy.parse(DateTime.now().toString())
                                  .format(pattern: 'yyyy-MM-dd'),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1))),
                          SizedBox(width: 10.w),
                          GestureDetector(
                              onTap: () => {},
                              child: Image.asset("assets/images/refresh.png",
                                  width: 13.w, height: 13.w))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("剩余：500条",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(153, 153, 153, 1))),
                          SizedBox(width: 10.w),
                          GestureDetector(
                              onTap: () => recordingManagement
                                  ? _recordingManagementEnd()
                                  : _recordingManagement(),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: recordingManagement
                                        ? const Color.fromRGBO(0, 125, 255, 1)
                                        : const Color.fromRGBO(
                                            245, 246, 248, 1),
                                    borderRadius: recordingManagement
                                        ? const BorderRadius.all(
                                            Radius.circular(50.0))
                                        : null),
                                width: 69.w,
                                height: 30.h,
                                alignment: Alignment.center,
                                child: Text(managementText,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: recordingManagement
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                153, 153, 153, 1))),
                              ))
                        ],
                      ))
                    ],
                  )),
              Expanded(
                  child: recordingManagement
                      ? ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(_items[index]["name"]),
                              value: _selections.contains(_items[index]["id"]),
                              onChanged: (bool? value) =>
                                  _handleItemChanged(index),
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          },
                        )
                      : Center(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                          Image.asset("assets/images/empty.png",
                              width: 147.w, height: 157.h),
                          Text("暂无数据",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      const Color.fromRGBO(153, 153, 153, 1)))
                        ]))),
              recordingManagement
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Row(children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  value: _isAllSelected,
                                  onChanged: (bool? value) =>
                                      _handleAllChanged()),
                            ),
                            Text("全选",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        const Color.fromRGBO(61, 61, 61, 1))),
                            SizedBox(width: 10.w),
                            Text("已选 （${_selections.length}）",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        const Color.fromRGBO(153, 153, 153, 1)))
                          ])),
                          Container(
                            padding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 10.w, right: 10.w),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(
                                  245, 34, 45, 0.15), // 半透明背景色
                              borderRadius:
                                  BorderRadius.circular(50), // 可选，设置圆角
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text('删除',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color.fromRGBO(
                                          245, 34, 45, 1))),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("安防录音须知:",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(245, 34, 45, 1))),
                          SizedBox(height: 10.h),
                          Text(
                              "此功能仅用于老人、小孩、车辆等安全防护紧急情况下合法使用，严禁用于非法用途，未经对方同意采集的音频文件无任何法律效力。 如非法使用录音自行承担法律责任，与本平台无关",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                          GestureDetector(
                            onTap: () => recordingBegins
                                ? _recordingEed()
                                : tipsDialog(),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 122, 255, 1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(recordingText,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
                            ),
                          )
                        ],
                      ),
                    )
            ]),
          );
        },
      ),
    );
  }
}
