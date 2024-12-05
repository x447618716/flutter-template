import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/refresh_builder.dart';
import 'package:flutter_template/src/data/json/alarm_param.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/settings/alarm/alarm_item.dart';

class AlarmSetView extends StatefulWidget {
  const AlarmSetView({super.key});


  @override
  State<AlarmSetView> createState() => _AlarmSetViewState();
}

class _AlarmSetViewState extends State<AlarmSetView> {
  late RefreshController<AlarmParam> _refreshController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.alarmSet,
      ),
      body: RefreshBuilder<AlarmParam>(
        future: (_, __) => context.deviceControllerRead.getAlarmParams(),
        refreshController: (controller) => _refreshController = controller,
        loadMore: false,
        builder: (BuildContext context, AlarmParam data) {
          return AlarmItem(
            data: data,
            onChanged: (data) async {
              final res =
                  await context.deviceControllerRead.updateAlarmParams([data]);
              if (res != null) {
                _refreshController.updateData(res);
              }
            },
          );
        },
      ),
    );
  }
}
