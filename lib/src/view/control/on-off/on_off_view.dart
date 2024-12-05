import 'package:flutter/cupertino.dart' show CupertinoSwitch, CupertinoColors;
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class OnOffView extends StatefulWidget {
  const OnOffView({super.key});

  @override
  State<StatefulWidget> createState() => _OnOffView();
}

class _OnOffView extends State<OnOffView> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: context.localization.remotePower,
        ),
        body: Container(
          color: const Color.fromRGBO(245, 246, 248, 1),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.w),
                height: 110.h,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(context.localization.remotePower,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        const Color.fromRGBO(61, 61, 61, 1)))),
                        Expanded(
                            child: Text(context.localization.onOffTipText,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(
                                        102, 102, 102, 1))))
                      ],
                    )),
                    Padding(
                        padding: EdgeInsets.all(10.w),
                        child: CupertinoSwitch(
                          value: switchValue,
                          activeColor: CupertinoColors.activeBlue,
                          onChanged: (bool? value) {
                            setState(() {
                              switchValue = value ?? false;
                            });
                          },
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
