import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/data/enums.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/control/trace/trace_item.dart';

class TraceModeView extends StatefulWidget {
  const TraceModeView({super.key});



  @override
  State<TraceModeView> createState() => _TraceModeViewState();
}

class _TraceModeViewState extends State<TraceModeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.traceMode,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.r),
        itemBuilder: (context, index) => TraceItem(
          index: index,
          selected: index == context.deviceControllerWatch.current?.traceMode.value,
          onTap: () {
            context.deviceControllerRead.updateDevice(traceMode: index);
          },
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemCount: TraceMode.values.length,
      ),
    );
  }
}
