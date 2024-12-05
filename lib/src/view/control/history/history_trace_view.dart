import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/control/history/query_panel.dart';

class HistoryTraceView extends StatefulWidget {
  const HistoryTraceView({super.key});


  @override
  State<HistoryTraceView> createState() => _HistoryTraceViewState();
}

class _HistoryTraceViewState extends State<HistoryTraceView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.historyTrace,
      ),
      body: Stack(
        children: [
          MapWidget(center: context.deviceControllerWatch.lastData?.coordinate),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: QueryPanel(),
          ),
        ],
      ),
    );
  }
}
