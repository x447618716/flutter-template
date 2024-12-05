import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/control/menu_item.dart';

class ControlView extends StatefulWidget {
  const ControlView({super.key});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.navControl,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/452.png',
                      title: context.localization.traceMode,
                      imageSize: Size(30.r, 27.r),
                      onPressed: () => TraceModeRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/185.png',
                      title: context.localization.historyTrace,
                      imageSize: Size(30.r, 27.r),
                      onPressed: () => HistoryTraceRoute().go(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/456.png',
                      title: context.localization.fence,
                      imageSize: Size(30.r, 27.r),
                      onPressed: () => ElectronicFenceRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/453.png',
                      title: context.localization.remotePower,
                      imageSize: Size(30.r, 30.r),
                      onPressed: () => OnOffRoute().go(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/448.png',
                      title: context.localization.troubleshooting,
                      imageSize: Size(30.r, 30.r),
                      onPressed: ()=> TroubleshootingRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/449.png',
                      title: context.localization.more,
                      imageSize: Size(30.r, 27.r),
                      onPressed: () => ControlMoreRoute().go(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
