import 'dart:convert';

import 'package:flutter/material.dart' hide AppBar, Dialog;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/dialog.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/data/json/device_icon.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/mdview/md_view.dart';
import 'package:flutter_template/src/view/settings/menu_item.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  //icon列表
  List<DeviceIcon> list = [];

  //当前选中项
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    if (context.deviceControllerRead.current != null && context.deviceControllerRead.current!.icon.isNotEmpty) {
      setState(() {
        currentIndex =
            int.parse(context.deviceControllerRead.current!.icon);
      });
    }

    _loadIconData();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.settingsControllerWatch.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: context.localization.navSettings,
        actions: [
          IconButton(
            icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () {
              if (isDark) {
                context.settingsControllerRead.updateThemeMode(ThemeMode.light);
              } else {
                context.settingsControllerRead.updateThemeMode(ThemeMode.dark);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              PhysicalModel(
                elevation: 1.0,
                borderRadius: BorderRadius.circular(15.r),
                color: context.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    children: [
                      iconNode(),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.deviceControllerWatch.current?.name ?? "",
                              style: context.titleMedium.copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              '${context.localization.deviceSN}: ${context.deviceControllerWatch.current?.deviceId}',
                              style: context.labelMedium.copyWith(
                                color: context.onPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              PhysicalModel(
                elevation: 1.0,
                borderRadius: BorderRadius.circular(15.r),
                color: context.backgroundColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Material(
                    child: Column(
                      children: [
                        MenuItem(
                          icon: 'assets/images/388.png',
                          title: context.localization.alarmSet,
                          onTap: () {
                            AlarmSetRoute().go(context);
                          },
                        ),
                        MenuItem(
                          icon: 'assets/images/385.png',
                          title: context.localization.shareDevice,
                          onTap: () => ShareRoute().go(context),
                        ),
                        MenuItem(
                          icon: 'assets/images/386.png',
                          title: context.localization.unbindDevice,
                          onTap: () => _unbind(context),
                        ),
                        MenuItem(
                          icon: 'assets/images/389.png',
                          title: context.localization.privacyPolicy,
                          onTap: () {
                            MdViewRoute(privacyPolicy).go(context);
                          },
                        ),
                        MenuItem(
                          icon: 'assets/images/390.png',
                          title: context.localization.agreement,
                          onTap: () {
                            MdViewRoute(agreement).go(context);
                          },
                        ),
                        MenuItem(
                          icon: 'assets/images/391.png',
                          title: context.localization.cancelRegistration,
                          onTap: () => _unregister(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Loading(
                future: () => _logout(context),
                backgroundColor: context.backgroundColor,
                progressColor: context.errorColor,
                child: Text(
                  context.localization.logout,
                  style: context.titleMedium.copyWith(
                    color: context.errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final res = await Dialog.confirm(
      content: Text(
        context.localization.logoutConfirm,
        style: context.titleMedium,
      ),
      confirmColor: context.errorColor,
    );
    if (res != true) {
      return;
    }
    if (context.mounted) {
      await context.loginControllerRead.logout();
    }

    if (context.mounted) {
      LoginRoute().go(context);
    }
  }

  Future<void> _unbind(BuildContext context) async {
    final res = await Dialog.confirm(
      title: Text(
        context.localization.unbindDevice,
        style: context.titleMedium,
      ),
      content: Text(
        context.localization.unbindConfirm,
        style: context.titleMedium,
      ),
      confirmColor: context.errorColor,
    );
    if (res != true) {
      return;
    }
    if (context.mounted) {
      final result = await context.deviceControllerRead.unbindDevice();
      if (result && context.mounted) {
        DevicesRoute().go(context);
      }
    }
  }

  Future<void> _unregister(BuildContext context) async {
    await Dialog.alert(
      title: Text(
        context.localization.cancelRegistration,
      ),
      content: Text(
        context.localization.cancelRegistrationTip,
      ),
    );
  }

  //加载图标数据
  Future<void> _loadIconData() async {
    Future<String> jsonString =
    DefaultAssetBundle.of(context).loadString('assets/device-icons.json');
    await jsonString.then((String value) {
      List iconList = json.decode(value);
      setState(() {
        list = iconList.map((item) => DeviceIcon.fromJson(item)).toList();
      });
    });
  }

  //图标节点
  Widget iconNode(){
    if (currentIndex != null && list.isNotEmpty){
      return  CircleAvatar(
        backgroundImage: AssetImage(list[currentIndex!].icon),
        radius: 25.r,
        backgroundColor: context.backgroundColor,
      );
    }else{
      return const Text("");
    }
  }
}
