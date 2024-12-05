import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/empty.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class ElectronicFenceView extends StatefulWidget {
  const ElectronicFenceView({super.key});

  @override
  State<StatefulWidget> createState() => _ElectronicFenceViewState();
}

class _ElectronicFenceViewState extends State<ElectronicFenceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.fence,
      ),
      body: Column(
        children: [
          const Expanded(child:Empty()),
          Container(
            width: 300.w,
            padding: EdgeInsets.all(20.w),
            child: ElevatedButton(
                onPressed: () => ElectronicFenceEditRoute().go(context),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 15.sp, color: Colors.white),
                    Text('添加',
                        style: TextStyle(fontSize: 15.sp, color: Colors.white))
                  ],
                )),
          )

        ],
      )
    );
  }
}
