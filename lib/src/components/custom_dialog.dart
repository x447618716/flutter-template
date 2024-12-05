import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class CustomDialog {
  static CustomDialog? _instance;
  static CustomDialog get instance => _instance ??= CustomDialog._();
  CustomDialog._();

  static alert({
    required BuildContext context,
    required Widget? content,
    Widget? title,
    String? confirmText,
    Color? confirmTextColor,
    VoidCallback? confirmEvent,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.w, left: 15.w, right: 15.w, bottom: 0),
                  child: title ??
                      Text(context.localization.dialogDefaultTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(61, 61, 61, 1))),
                ),
                Padding(padding: EdgeInsets.all(15.w), child: content),
                Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                            top: BorderSide(
                                width: 0.5.w,
                                color:
                                    const Color.fromRGBO(225, 225, 225, 1)))),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (confirmEvent != null) {
                          confirmEvent();
                        }
                      },
                      child: Text(confirmText ?? context.localization.confirm,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: confirmTextColor ??
                                  const Color.fromRGBO(245, 34, 45, 1))),
                    ))
              ],
            ),
          )),
    );
  }

  static confirm(
      {required BuildContext context,
      required Widget content,
      Widget? title,
      String? confirmText,
      Color? confirmTextColor,
      String? cancelText,
      Color? cancelTextColor,
      VoidCallback? confirmEvent,
      VoidCallback? cancelEvent}) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          child: IntrinsicWidth(
            stepWidth: 335.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.w, left: 15.w, right: 15.w, bottom: 0),
                  child: title ??
                      Text(context.localization.dialogDefaultTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(61, 61, 61, 1))),
                ),
                Padding(padding: EdgeInsets.all(15.w), child: content),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    top: BorderSide(
                                        width: 0.5.w,
                                        color: const Color.fromRGBO(
                                            225, 225, 225, 1)),
                                    end: BorderSide(
                                        width: 0.5.w,
                                        color: const Color.fromRGBO(
                                            225, 225, 225, 1)))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (cancelEvent != null) {
                                  cancelEvent();
                                }
                              },
                              child: Text(
                                  cancelText ?? context.localization.cancel,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: cancelTextColor ??
                                          const Color.fromRGBO(61, 61, 61, 1))),
                            ))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                                    top: BorderSide(
                                        width: 0.5.w,
                                        color: const Color.fromRGBO(
                                            225, 225, 225, 1)))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (confirmEvent != null) {
                                  confirmEvent();
                                }
                              },
                              child: Text(
                                  confirmText ?? context.localization.confirm,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: confirmTextColor ??
                                          const Color.fromRGBO(
                                              245, 34, 45, 1))),
                            )))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
