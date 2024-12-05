import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/empty.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class ShareView extends StatefulWidget {
  const ShareView({super.key});

  @override
  State<StatefulWidget> createState() => _ShareView();
}

class _ShareView extends State<ShareView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.shareDevice,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("暂支持分享最多3人",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color.fromRGBO(102, 102, 102, 1))),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.blue,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  child: IconButton(
                      onPressed: () => {
                        ShareEditRoute().go(context)
                      },
                      icon: const Icon(Icons.add_circle,
                          size: 25.0, color: Colors.blue)),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.blue,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  child: IconButton(
                      onPressed: () => {
                        ShareEditRoute().go(context)
                      },
                      icon: const Icon(Icons.add_circle,
                          size: 25.0, color: Colors.blue)),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.blue,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  child: IconButton(
                      onPressed: () => {
                        ShareEditRoute().go(context)
                      },
                      icon: const Icon(Icons.add_circle,
                          size: 25.0, color: Colors.blue)),
                )
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("分享记录",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(61, 61, 61, 1)))),
                  const Expanded(child: Empty())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
