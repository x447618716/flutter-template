import 'package:flutter/material.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/controllers/device_controller.dart';
import 'package:flutter_template/src/data/api.dart';

class LoginController extends ChangeNotifier {
  LoginController(this._deviceController);

  final DeviceController _deviceController;

  Future<void> logout() async {
    await Api.instance.logout();
    _deviceController.clearDevices();
  }

  Future<void> login(BuildContext context, String phone, String code) async {
    final res = await Api.instance.login(phone, code);
    if (!res) {
      return;
    }
    await _deviceController.loadDevices();
    if (_deviceController.hasDevices) {
      if (context.mounted) {
        LoactionRoute().go(context);
      }
    } else {
      if (context.mounted) {
        DevicesRoute().go(context);
      }
    }
  }

  Future<bool> sendCode(String phone) async {
    return await Api.instance.sendCode(phone);
  }
}
