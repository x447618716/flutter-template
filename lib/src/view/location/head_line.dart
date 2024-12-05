import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/data/json/last_data.dart';
import 'package:flutter_template/src/theme.dart';

class HeadLine extends StatelessWidget {
  const HeadLine({super.key, required this.lastData});

  final LastData? lastData;

  //电量图标
  IconData batteryIcon() {
    if (lastData != null && !lastData!.battery.isNaN) {
      if (lastData?.battery == 100) {
        return Icons.battery_full;
      } else if (90 <= lastData!.battery && lastData!.battery < 100) {
        return Icons.battery_6_bar;
      } else if (70 <= lastData!.battery && lastData!.battery < 90) {
        return Icons.battery_5_bar;
      } else if (50 <= lastData!.battery && lastData!.battery < 70) {
        return Icons.battery_4_bar;
      } else if (40 <= lastData!.battery && lastData!.battery < 50) {
        return Icons.battery_3_bar;
      } else if (30 <= lastData!.battery && lastData!.battery < 40) {
        return Icons.battery_2_bar;
      } else if (15 <= lastData!.battery && lastData!.battery < 30) {
        return Icons.battery_1_bar;
      } else {
        return Icons.battery_0_bar;
      }
    } else {
      return Icons.battery_0_bar;
    }
  }

  //信号强度
  IconData signalStrength() {
    if(lastData != null){
      if (lastData?.signal.value == 0) {
        return Icons.signal_cellular_alt;
      } else if (lastData?.signal.value == 1) {
        return Icons.signal_cellular_alt_2_bar;
      } else {
        return Icons.signal_cellular_alt_1_bar;
      }
    }else{
      return Icons.signal_cellular_alt_1_bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(context.deviceControllerWatch.current?.name ?? "",
          style: context.titleSmall,
        ),
        const Spacer(),
        Text(
          context.deviceControllerWatch.lastData?.duration ?? "",
          style: context.titleSmall.copyWith(color: context.primaryColor),
        ),
        const Spacer(
          flex: 4,
        ),
        Text(
          '4G',
          style: context.titleSmall.copyWith(
            color: MaterialTheme.warning.value,
          ),
        ),
        Icon(
          signalStrength(),
          color: MaterialTheme.warning.value,
          size: 18.sp,
        ),
        const Spacer(),
        Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            batteryIcon(),
            color: MaterialTheme.green.value,
            size: 18.sp,
          ),
        ),
        Text(
          '${lastData?.battery ?? 0}%',
          style: context.titleSmall.copyWith(
            color: MaterialTheme.green.value,
          ),
        ),
      ],
    );
  }
}
