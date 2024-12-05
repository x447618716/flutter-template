import 'package:flutter/material.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class Dialog {
  static BuildContext Function() _getContextFn = () => throw 'no context';
  static void set(BuildContext Function() context) => _getContextFn = context;

  static Widget _title(BuildContext context) => Text(
        context.localization.dialogDefaultTitle,
        style: context.titleMedium,
      );

  static List<Widget> _actions(
    BuildContext context, {
    bool confirm = true,
    Color? confirmColor,
  }) =>
      <Widget>[
        if (confirm)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              context.localization.cancel,
              style: context.labelLarge,
            ),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            context.localization.confirm,
            style: context.labelLarge.copyWith(
              color: confirmColor ?? context.primaryColor,
            ),
          ),
        ),
      ];

  static Future alert({
    Widget? content,
    Widget? title,
    Color? confirmColor,
  }) {
    return showDialog(
      context: _getContextFn(),
      builder: (BuildContext context) => AlertDialog(
        title: title ?? _title(context),
        content: content,
        actions: _actions(context, confirm: false),
      ),
    );
  }

  static Future<bool?> confirm({
    Widget? content,
    Widget? title,
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: _getContextFn(),
      builder: (BuildContext context) => AlertDialog(
        title: title ?? _title(context),
        content: content,
        actions: _actions(
          context,
          confirmColor: confirmColor,
        ),
      ),
    );
  }
}
