import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0XFF282828),
    secondaryContainer: Color(0XFFC6C6C6),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0XFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFF181818),
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0XFFFFFCFC)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF15B86C);
      } else {
        return Color(0XFFFFFFFF);
      }
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFFFFFFFF);
      } else {
        return Color(0XFF9E9E9E);
      }
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      } else {
        return Color(0XFF9E9E9E);
      }
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      } else {
        return 2;
      }
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0XFF14A662)),
      foregroundColor: WidgetStateProperty.all(Color(0XFFFFFFFF)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0XFFFFFFFF)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0XFFFFFFFF),
    backgroundColor: Color(0XFF14A662),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Color(0XFFC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0XFFA0A0A0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0XFFFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    labelMedium: TextStyle(color: Color(0XFFFFFFFF), fontSize: 16),
    displaySmall: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0XFFFFFFFF)),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
    filled: true,
    fillColor: Color(0XFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
  iconTheme: IconThemeData(color: Color(0XFFFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0XFF6E6E6E)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0XFF181818),
    unselectedItemColor: Color(0XFFC6C6C6),
    selectedItemColor: Color(0XFF15B86C),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFF181818),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Color(0XFFFFFFFF), fontSize: 18),
    ),
  ),
);
