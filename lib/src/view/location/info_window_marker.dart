import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/controllers/device_controller.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class InfoWindowMarker extends StatelessWidget {
  const InfoWindowMarker({super.key, required this.deviceController, required this.context2});

  final DeviceController deviceController;
  final BuildContext context2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 246.w,
      margin: EdgeInsets.only(right: 30.w),
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
      decoration: BoxDecoration(
          color: context2.backgroundColor,
          borderRadius: BorderRadius.circular(12.w)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(deviceController.lastData?.deviceId ?? "",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromRGBO(51, 51, 51, 1)))),
              SizedBox(width: 10.w),
              Icon(Icons.clear_rounded, size: 25.w, color: Colors.grey),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${deviceController.lastData?.mileage.toStringAsFixed(0)}/km",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
              SizedBox(width: 5.w),
              const Text("|",
                  style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1))),
              Text("${deviceController.lastData?.speed.toStringAsFixed(0)}km/h",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
              const Text("|",
                  style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1))),
              Text(deviceController.lastData?.traceMode.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
              const Text("|",
                  style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1))),
              SizedBox(width: 5.w),
              Text(deviceController.lastData?.locateMode.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
            ],
          ),
          SizedBox(height: 5.w),
          Row(
            children: [
              Text(context2.localization.positioningTime,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
              SizedBox(width: 10.w),
              Expanded(
                  child: Text(deviceController.lastData?.locatedTime ?? "",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(51, 51, 51, 1))))
            ],
          ),
          SizedBox(height: 5.w),
          Row(
            children: [
              Text(context2.localization.signalTime,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(102, 102, 102, 1))),
              SizedBox(width: 10.w),
              Expanded(
                  child: Text(deviceController.lastData?.receivedTime ?? "",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(51, 51, 51, 1))))
            ],
          )
        ],
      ),
    );
  }
}
