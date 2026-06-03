import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  static ValueNotifier<ThemeMode> themeNotofier = ValueNotifier(ThemeMode.dark);

  static init() {
    final result = PreferencesManagers().getBool("theme") ?? true;
    if (result) {
      themeNotofier.value = ThemeMode.dark;
    } else {
      themeNotofier.value = ThemeMode.light;
    }
  }

  static toggleTheme() async {
    if (themeNotofier.value == ThemeMode.dark) {
      themeNotofier.value = ThemeMode.light;
      await PreferencesManagers().setBool("theme", false);
    } else {
      themeNotofier.value = ThemeMode.dark;
      await PreferencesManagers().setBool("theme", true);
    }
  }

  static isDark() => themeNotofier.value == ThemeMode.dark;
}
