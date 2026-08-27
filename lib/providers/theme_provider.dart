import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static final ThemeProvider instance = ThemeProvider._();
  static const _key = 'dark_mode';
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeProvider._();

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    _isDark = preferences.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDark = value;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_key, value);
  }
}
