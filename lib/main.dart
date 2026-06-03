import 'package:flutter/material.dart';
import 'package:tests/core/theme/dark_theme.dart';
import 'package:tests/core/theme/light_theme.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/screens/main_screen.dart';
import 'package:tests/screens/welcome_Screen.dart';

import 'core/services/preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManagers().init();
  ThemeController.init();
  final userName = PreferencesManagers().getString("username");
  return runApp(MyApp(username: userName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotofier,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
