import 'dart:io';

import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:image_picker/image_picker.dart';

class AddFeedbackView extends StatefulWidget {
  const AddFeedbackView({super.key});

  @override
  State<StatefulWidget> createState() => _AddFeedbackView();
}

class _AddFeedbackView extends State<AddFeedbackView> {
  int feedbackType = 0;
  final ImagePicker picker = ImagePicker();
  XFile? image;


  void _openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        title: context.localization.addFeedback,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (feedbackType != 0) {
                        setState(() {
                          feedbackType = 0;
                        });
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            feedbackType == 0
                                ? const Color.fromRGBO(0, 122, 255, 1)
                                : const Color.fromRGBO(
                                    245, 246, 248, 1)), // 设置背景色
                        elevation: WidgetStateProperty.all(0), // 取消凸起效果
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50.0), // 可选：设置圆角
                          ),
                        ),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 20.w))),
                    child: Text('产品建议',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: feedbackType == 0
                                ? Colors.white
                                : const Color.fromRGBO(153, 153, 153, 1)))),
                ElevatedButton(
                    onPressed: () {
                      if (feedbackType != 1) {
                        setState(() {
                          feedbackType = 1;
                        });
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            feedbackType == 1
                                ? const Color.fromRGBO(0, 122, 255, 1)
                                : const Color.fromRGBO(
                                    245, 246, 248, 1)), // 设置背景色
                        elevation: WidgetStateProperty.all(0), // 取消凸起效果
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50.0), // 可选：设置圆角
                          ),
                        ),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 20.w))),
                    child: Text('功能故障',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: feedbackType == 1
                                ? Colors.white
                                : const Color.fromRGBO(153, 153, 153, 1)))),
                ElevatedButton(
                    onPressed: () {
                      if (feedbackType != 2) {
                        setState(() {
                          feedbackType = 2;
                        });
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            feedbackType == 2
                                ? const Color.fromRGBO(0, 122, 255, 1)
                                : const Color.fromRGBO(
                                    245, 246, 248, 1)), // 设置背景色
                        elevation: WidgetStateProperty.all(0), // 取消凸起效果
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50.0), // 可选：设置圆角
                          ),
                        ),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 20.w))),
                    child: Text('其他问题',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: feedbackType == 2
                                ? Colors.white
                                : const Color.fromRGBO(153, 153, 153, 1))))
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
              margin: EdgeInsets.symmetric(vertical: 20.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 246, 248, 1),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      style: TextStyle(fontSize: 15.sp),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: '请输入标题',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                      )),
                  TextField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '请您详细填写内容，以便我们更好的为您解决问题',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                      ))
                ],
              ),
            ),
            Container(
              width: 75.w,
              height: 75.w,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 246, 248, 1),
                  borderRadius: BorderRadius.circular(30.0)),
              child: TextButton(
                onPressed: () => _openGallery(),
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent)),
                child: image != null ? Image.file(File(image!.path),width: 75.w, height: 75.w) : const Icon(
                  Icons.add_a_photo,
                  color: Colors.grey,
                  size: 35.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
              margin: EdgeInsets.symmetric(vertical: 20.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 246, 248, 1),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 50.w,
                          child: Text("称呼",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      SizedBox(width: 10.w),
                      Expanded(
                          child: TextField(
                              style: TextStyle(fontSize: 15.sp),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入标题',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                              )))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 50.w,
                          child: Text("手机号",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      SizedBox(width: 10.w),
                      Expanded(
                          child: TextField(
                              style: TextStyle(fontSize: 15.sp),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入标题',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                              )))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 50.w,
                          child: Text("邮箱",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(61, 61, 61, 1)))),
                      SizedBox(width: 10.w),
                      Expanded(
                          child: TextField(
                              style: TextStyle(fontSize: 15.sp),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入标题',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                              )))
                    ],
                  )
                ],
              ),
            ),
            Center(
                child: SizedBox(
              width: 300.w,
              child: ElevatedButton(
                  onPressed: () => {},
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromRGBO(0, 122, 255, 1)), // 设置背景色
                      elevation: WidgetStateProperty.all(0), // 取消凸起效果
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0), // 可选：设置圆角
                        ),
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.all(10.w))),
                  child: Text('提交',
                      style: TextStyle(fontSize: 15.sp, color: Colors.white))),
            ))
          ],
        ),
      ),
    );
  }
}
