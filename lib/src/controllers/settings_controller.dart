import 'package:flutter/material.dart';
import 'package:flutter_template/src/application.dart';

class SettingsController extends ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.values[Application.prefsWithCache.getInt('themeIndex') ?? 0];
  ThemeMode get themeMode => _themeMode;

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await Application.prefsWithCache.setInt('themeIndex', newThemeMode.index);
  }

}
