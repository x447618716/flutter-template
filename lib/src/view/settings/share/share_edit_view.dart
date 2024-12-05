import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class ShareEditView extends StatefulWidget {
  const ShareEditView({super.key});

  @override
  State<StatefulWidget> createState() => _ShareEditView();
}

class _ShareEditView extends State<ShareEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.sharedDevices,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: [
                  Text("分享对象",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromRGBO(61, 61, 61, 1))),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        hintText: "请输入手机号码"),
                  ))
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("分享时长",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromRGBO(61, 61, 61, 1))),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 122, 255, 0.15),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("永久",style: TextStyle(fontSize: 12.sp,color: const Color.fromRGBO(0, 122, 255, 1))),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("24小时",style: TextStyle(fontSize: 12.sp,color: const Color.fromRGBO(153, 153, 153, 1))),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("7天",style: TextStyle(fontSize: 12.sp,color: const Color.fromRGBO(153, 153, 153, 1))),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("15天",style: TextStyle(fontSize: 12.sp,color: const Color.fromRGBO(153, 153, 153, 1))),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 246, 248, 1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("30天",style: TextStyle(fontSize: 12.sp,color: const Color.fromRGBO(153, 153, 153, 1))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
