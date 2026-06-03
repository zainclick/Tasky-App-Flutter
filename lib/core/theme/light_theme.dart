import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFF3A4640),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0XFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0XFF161F1B)),
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
      foregroundColor: WidgetStateProperty.all(Color(0XFF000000)),
    )
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0XFFFFFFFF),
    backgroundColor: Color(0XFF14A662),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Color(0XFF3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0XFF6A6A6A),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0XFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    labelMedium: TextStyle(color: Color(0XFF000000), fontSize: 16),
    displaySmall: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0XFF000000)),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    focusColor: Color(0XFF00000),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0XFFD1DAD6), width: 1),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0XFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0XFFD1DAD6)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0XFFF6F7F9),
    unselectedItemColor: Color(0XFF3A4640),
    selectedItemColor: Color(0XFF14A662),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0XFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Color(0XFF000000), fontSize: 18),
    ),
  ),
);
