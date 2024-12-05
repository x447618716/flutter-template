import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/devices/tab_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});


  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            context.localization.selectDevice,
            style: context.titleLarge,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: context.localization.myDevices,
              ),
              Tab(
                text: context.localization.sharedDevices,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TabPanel(
              devices: context.deviceControllerWatch.devices,
              onDeviceTap: onDeviceTapped,
              onRefresh: () => context.deviceControllerRead.loadDevices(),
            ),
            TabPanel(
              devices: context.deviceControllerWatch.shareDevices,
              onDeviceTap: onDeviceTapped,
              onRefresh: () => context.deviceControllerRead.loadDevices(),
            ),
          ],
        ),
      ),
    );
  }


  Future<bool> onDeviceTapped(Device device) async {
    final Uri url = Uri.parse("weixin://dl/business/?appid=wx8d93f377eecbe1a9&path=/pages/index/index&env_version=trial");
    await launchUrl(url,mode: LaunchMode.platformDefault);
    return false;
   // return await context.deviceControllerRead.setDefault(device.deviceId!);
  }

}
