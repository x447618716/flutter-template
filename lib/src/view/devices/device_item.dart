import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    super.key,
    required this.device,
    required this.index,
    required this.onTap,
  });

  final Device device;
  final int index;
  final Future<bool> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhysicalModel(
          color: context.backgroundColor,
          elevation: 1.0,
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: device.defaultValue == 1
                    ? context.primaryColor
                    : context.onPrimaryColor,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(
                            device.name ?? '',
                            style: context.titleMedium,
                          )),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.r,
                              vertical: 3.r,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: context.primaryColor,
                            ),
                            child: Text(
                              device.onlineStatus.name,
                              style: context.bodySmall.copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w)
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${context.localization.deviceSN}: ${device.deviceId}',
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onTap().then((value) {
                      if (value) {
                        LoactionRoute().go(context);
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: context.primaryContainerColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.r, vertical: 10.r),
                  ),
                  child: Text(
                    context.localization.gotoDevice,
                    style: context.labelMedium.copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 48.w,
            height: 23.h,
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: context.bodySmall.copyWith(
                color: context.onPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
