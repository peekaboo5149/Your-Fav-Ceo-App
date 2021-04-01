// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/constants.dart';

// class DynamicTheme with ChangeNotifier {
//   bool _isDarkMode;
//   DynamicTheme() {
//     _isDarkMode = false;
//     // loadPrefrences();
//   }

//   ThemeData get theme => this._isDarkMode ? kdarkthemeData : klightThemeData;

//   toogleTheme() {
//     updateTheme(isDark: !_isDarkMode);
//   }

//   updateTheme({bool isDark}) {
//     this._isDarkMode = isDark ?? this._isDarkMode;
//     // saveprefrences();
//     notifyListeners();
//   }

//   IconData get appIcon => _isDarkMode ? Icons.brightness_4 : Icons.brightness_2;

//   saveprefrences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('dark', _isDarkMode);
//   }

//   loadPrefrences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs == null) _isDarkMode = false;
//     _isDarkMode = prefs.getBool('dark');
//   }
// }

import 'package:flutter/material.dart';
import 'package:your_fav_ceo/application/theme/dynamic_theme_prefs.dart';
import 'package:your_fav_ceo/core/constants.dart';

class DynamicTheme with ChangeNotifier {
  DynamicThemePreference darkThemePreference = DynamicThemePreference();

  bool _darkTheme;

  DynamicTheme() {
    this._darkTheme = false;
  }

  bool get darkTheme {
    //Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    if (_darkTheme == null) _darkTheme = false;
    return _darkTheme;
  }

  set darkTheme(bool value) {
    //Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    if (_darkTheme == null) {
      _darkTheme = false;
      darkThemePreference.setDarkTheme(_darkTheme);
    } else {
      _darkTheme = value;
      darkThemePreference.setDarkTheme(value);
    }
    notifyListeners();
  }

  ThemeData get theme => this._darkTheme ? kdarkthemeData : klightThemeData;
  IconData get appIcon =>
      this._darkTheme ? Icons.brightness_4 : Icons.brightness_2;
}
