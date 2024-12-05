import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/custom_dialog.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/control/menu_item.dart';

class ControlMoreView extends StatefulWidget {
  const ControlMoreView({super.key});

  @override
  State<ControlMoreView> createState() => _ControlMoreViewState();
}

class _ControlMoreViewState extends State<ControlMoreView> {
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
                      image: 'assets/images/454.png',
                      title: context.localization.soundProtection,
                      imageSize: Size(30.r, 30.r),
                      onPressed: () =>
                          VoiceControlledAntiTheftRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/186.png',
                      title: context.localization.deviceDetail,
                      imageSize: Size(30.r, 30.r),
                      onPressed: () => DeviceDetailsRoute().go(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/455.png',
                      title: context.localization.remoteRestart,
                      imageSize: Size(30.r, 30.r),
                      onPressed: () {
                        CustomDialog.confirm(
                            context: context,
                            content: Text("是否重启设备",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 1))));
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/459.png',
                      title: context.localization.commandHistory,
                      imageSize: Size(30.r, 30.r),
                      onPressed: ()=> InstructionRecordingRoute().go(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/460.png',
                      title: context.localization.alarmSettings,
                      imageSize: Size(30.r, 30.r),
                      onPressed: ()=> AlarmSettingsRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/457.png',
                      title: context.localization.tripReport,
                      imageSize: Size(27.r, 27.r),
                      onPressed: ()=> TravelReportRoute().go(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MenuItem(
                      image: 'assets/images/458.png',
                      title: context.localization.helpAndFeedback,
                      imageSize: Size(30.r, 30.r),
                      onPressed: ()=>HelpAndFeedbackRoute().go(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  const Expanded(
                    child: SizedBox.square(),
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
