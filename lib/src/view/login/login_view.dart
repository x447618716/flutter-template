import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/mdview/md_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _phone = '';
  String _code = '';
  int _times = 0;
  Timer? _timer;

  bool _checkPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 104.h),
              Text(
                context.localization.phoneNumber,
                style: context.bodyMedium,
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                  color: context.surfaceVariantColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  style: context.titleMedium,
                  decoration: InputDecoration(
                    hintText: context.localization.phoneNumberHint,
                    hintStyle: context.bodyMedium.copyWith(
                      color: context.bodyMedium.color!.withOpacity(0.6),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _phone = value,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                context.localization.verificationCode,
                style: context.bodyMedium,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.surfaceVariantColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: context.titleMedium,
                        decoration: InputDecoration(
                          hintText: context.localization.verificationCodeHint,
                          hintStyle: context.bodyMedium.copyWith(
                            color: context.bodyMedium.color!.withOpacity(0.6),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => _code = value,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Loading(
                    future: () => _sendCode(),
                    backgroundColor: context.surfaceVariantColor,
                    padding: EdgeInsets.all(18.h),
                    expanded: false,
                    child: Text(
                      _times == 0
                          ? context.localization.getVerificationCode
                          : '$_times s',
                      style: context.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Loading(
                future: () => _login(),
                child: Text(
                  context.localization.login,
                  style: context.titleMedium.copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Checkbox(
                    value: _checkPrivacy,
                    side: BorderSide(color: context.secondaryColor),
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _checkPrivacy = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: context.localization.iHaveReadAndUnderstood,
                        children: [
                          TextSpan(
                            text: context.localization.agreementQuotationMark,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const MdView(
                                        file: agreement,
                                      );
                                    },
                                  ),
                                );
                              },
                            style: context.bodySmall.copyWith(
                              color: context.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text:
                                context.localization.privacyPolicyQuotationMark,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const MdView(
                                        file: privacyPolicy,
                                      );
                                    },
                                  ),
                                );
                              },
                            style: context.bodySmall.copyWith(
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      style: context.bodySmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  _sendCode() async {
    if (_phone.isEmpty) {
      EasyLoading.showToast(context.localization.phoneNumberHint);
      return;
    }
    if (_timer != null) {
      return;
    }
    final res = await context.loginControllerRead.sendCode(_phone);
    if (res) {
      setState(() {
        _times = 60;
      });
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_times == 0) {
            timer.cancel();
            _timer = null;
            return;
          }
          setState(() {
            _times = _times - 1;
          });
        },
      );
    }
  }

  _login() async {
    if (_phone.isEmpty) {
      EasyLoading.showToast(context.localization.phoneNumberHint);
      return;
    }
    if (_code.isEmpty) {
      EasyLoading.showToast(context.localization.verificationCodeHint);
      return;
    }
    if (!_checkPrivacy) {
      EasyLoading.showToast(context.localization.readProtocolHint);
      return;
    }

    await context.loginControllerRead.login(context, _phone, _code);
  }
}
