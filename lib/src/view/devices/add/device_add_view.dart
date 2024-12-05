import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter/services.dart';
import 'package:flutter_easy_permission/flutter_easy_permission.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/common/constants.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class DeviceAddView extends StatefulWidget {
  const DeviceAddView({
    super.key,
  });

  @override
  State<DeviceAddView> createState() => _DeviceAddViewState();
}

class _DeviceAddViewState extends State<DeviceAddView> {
  late final ScanKit scanKit;
  final TextEditingController _deviceSN = TextEditingController();
  String _deviceName = '';

  @override
  void initState() {
    super.initState();
    scanKit = ScanKit();
    scanKit.onResult.listen((val) {
      _deviceSN.value = TextEditingValue(text: val.originalValue);
    });

    FlutterEasyPermission().addPermissionCallback(
        onGranted: (requestCode, perms, perm) {
          _startScan();
        },
        onDenied: (requestCode, perms, perm, isPermanent) {});
  }

  @override
  void dispose() {
    scanKit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.deiveAdd,
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Row(
                  children: [
                    SizedBox(
                      width: 64.w,
                      child: Text(
                        context.localization.deiveName,
                        style: context.labelLarge,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: context.localization.deiveNameHint,
                          hintStyle: context.bodyMedium.copyWith(
                            color: context.bodyMedium.color!.withOpacity(0.6),
                          ),
                        ),
                        onChanged: (value) => _deviceName = value,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        context.localization.deviceSN,
                        style: context.labelLarge,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: _deviceSN,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => _camera(),
                            child: const Icon(Icons.camera_alt),
                          ),
                          hintText: context.localization.deiveSNHint,
                          hintStyle: context.bodyMedium.copyWith(
                            color: context.bodyMedium.color!.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Loading(
                  future: _addDevice,
                  child: Text(
                    context.localization.confirm,
                    style: context.titleMedium.copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _camera() async {
    if (!await FlutterEasyPermission.has(
        perms: permissions, permsGroup: permissionGroup)) {
      FlutterEasyPermission.request(
          perms: permissions, permsGroup: permissionGroup);
    } else {
      _startScan();
    }
  }

  _startScan() async {
    try {
      await scanKit.startScan(scanTypes: ScanTypes.code128.bit);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _addDevice() async {
    if (_deviceName.isEmpty) {
      EasyLoading.showToast(context.localization.deiveNameHint);
      return;
    }
    if (_deviceSN.text.isEmpty) {
      EasyLoading.showToast(context.localization.deiveSNHint);
      return;
    }

    context.deviceControllerRead.addDevice(_deviceName, _deviceSN.text).then((value) {
      if (value) {
        context.pop();
      }
    });
  }
}
