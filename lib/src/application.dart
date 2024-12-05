import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/device_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/settings_controller.dart';

class Application {
  static late final SharedPreferencesWithCache prefsWithCache;
  static final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  ///应用初始化
  static init() async {
    //获取存储实例
    prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    //地图初始化
    await MapWidgetController.init();

    //提示组件配置
    EasyLoading.instance
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..radius = 50.0
      ..contentPadding =
          const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0)
      ..fontSize = 13.0
      ..animationStyle = EasyLoadingAnimationStyle.offset;
  }
}

extension CustomException on BuildContext {
  DeviceController get deviceControllerWatch => Provider.of<DeviceController>(this);
  DeviceController get deviceControllerRead => Provider.of<DeviceController>(this, listen: false);
  SettingsController get settingsControllerWatch => Provider.of<SettingsController>(this);
  SettingsController get settingsControllerRead => Provider.of<SettingsController>(this, listen: false);
  LoginController get loginControllerWatch => Provider.of<LoginController>(this);
  LoginController get loginControllerRead => Provider.of<LoginController>(this, listen: false);

}
