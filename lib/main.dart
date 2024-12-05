import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/controllers/device_controller.dart';
import 'package:flutter_template/src/controllers/login_controller.dart';
import 'package:flutter_template/src/controllers/settings_controller.dart';
import 'package:flutter_template/src/data/api.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/data/json/last_data.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Application.init();
  // 设置状态栏背景颜色
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  List<Device>? devices = await Api.instance.getDevices();
  Device? current = (devices != null &&
          devices.isNotEmpty &&
          devices.any((element) => element.defaultValue == 1))
      ? devices.firstWhere((element) => element.defaultValue == 1)
      : null;
  LastData? lastData = current != null && current.deviceId != null
      ? await Api.instance.getLast(current.deviceId!)
      : null;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => DeviceController(context,devices ?? [], lastData)),
        ChangeNotifierProvider(create: (context) => SettingsController()),
        ChangeNotifierProxyProvider<DeviceController, LoginController?>(
            create: (BuildContext context) => null,
            update: (BuildContext context, DeviceController deviceController,
                    LoginController? previous) =>
                LoginController(deviceController)),
      ],
      child: const MyApp(),
    ),
  );
}
