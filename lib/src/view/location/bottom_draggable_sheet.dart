import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/location/head_line.dart';
import 'package:flutter_template/src/view/location/icon_text_row.dart';
import 'package:flutter_template/src/view/location/image_rich_text_row.dart';

class BottomDraggableSheet extends StatefulWidget {
  const BottomDraggableSheet({
    super.key,
    required this.panelKey,
    required this.maxChildSize,
    required this.onRefresh,
  });

  final GlobalKey panelKey;
  final double maxChildSize;
  final VoidCallback onRefresh;

  @override
  State<BottomDraggableSheet> createState() => _BottomDraggableSheetState();
}

class _BottomDraggableSheetState extends State<BottomDraggableSheet> {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: widget.maxChildSize,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ).r,
            child: PhysicalModel(
              key: widget.panelKey,
              color: context.backgroundColor,
              borderRadius: BorderRadius.circular(24).r,
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ).r,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: context.onBackgroundColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5).r,
                        ),
                      ),
                    ),
                    HeadLine(lastData: context.deviceControllerWatch.lastData),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              IconTextRow(
                                text: context.deviceControllerWatch.lastData?.address ?? "",
                                iconColor: context.primaryColor,
                                icon: Icons.location_on,
                              ),
                              SizedBox(height: 10.h),
                              IconTextRow(
                                text: context.deviceControllerWatch.lastData?.alarmTextList.join(',') ?? "",
                                iconColor: context.errorColor,
                                icon: Icons.notifications,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ElevatedButton(
                          onPressed: () {
                            widget.onRefresh();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ).r,
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10).r,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.refresh_outlined,
                                color: context.onPrimaryColor,
                              ),
                              Text(
                                context.localization.locate,
                                style: context.labelMedium.copyWith(
                                  color: context.onPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: ImageRichTextRow(
                            image: 'assets/images/333-1.png',
                            text: context.localization.deviceState,
                            subText: context.deviceControllerWatch.lastData?.deviceStatus.name ?? "",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ImageRichTextRow(
                            image: 'assets/images/333-2.png',
                            text: context.localization.netState,
                            subText: context.deviceControllerWatch.lastData?.signal.name ?? "",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: ImageRichTextRow(
                            image: 'assets/images/333-3.png',
                            text: context.localization.battery,
                            subText: context.localization.batteryValue(
                              context.deviceControllerWatch.lastData?.battery ?? 0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ImageRichTextRow(
                            image: 'assets/images/333-4.png',
                            text: context.localization.satelliteSignal,
                            subText: context.deviceControllerWatch.lastData?.gpsSignal.name ?? "",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
