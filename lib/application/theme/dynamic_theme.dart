import 'package:flutter/material.dart';
import '../../core/constants.dart';

class DynamicTheme with ChangeNotifier {
  bool _isDarkMode;
  DynamicTheme() {
    _isDarkMode = false;
  }

  ThemeData get theme => this._isDarkMode ? kdarkthemeData : klightThemeData;

  toogleTheme() {
    updateTheme(isDark: !_isDarkMode);
  }

  updateTheme({bool isDark}) {
    this._isDarkMode = isDark ?? this._isDarkMode;
    notifyListeners();
  }

  IconData get appIcon => _isDarkMode ? Icons.brightness_4 : Icons.brightness_2;
}
