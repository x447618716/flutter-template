import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/devices/device_item.dart';

class TabPanel extends StatelessWidget {
  const TabPanel({
    super.key,
    required this.devices,
    required this.onDeviceTap,
    required this.onRefresh,
  });

  final List<Device> devices;
  final Future<bool> Function(Device) onDeviceTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            context.localization.deiveSelectTip,
            style: context.bodySmall.copyWith(
              color: context.secondaryColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) {
                final device = devices[index];
                return DeviceItem(
                  device: device,
                  index: index + 1,
                  onTap: () => onDeviceTap(device),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
              itemCount: devices.length,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            SizedBox(width: 20.w),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15.r),
                  backgroundColor: context.primaryColor,
                ),
                onPressed: () {
                  DeviceAddRoute().go(context);
                },
                child: Text(
                  context.localization.deiveAdd,
                  style: context.titleMedium.copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
