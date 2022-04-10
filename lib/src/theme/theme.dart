import 'package:flutter/material.dart';

class AppTheme {
  static const Color accentColor = Colors.deepPurple;
  static const Color lightColor = Colors.white;
  static const Color darkColor = Colors.black;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: lightColor,
    scaffoldBackgroundColor: lightColor,

    colorScheme: ColorScheme.fromSwatch().copyWith(
      onSurface: darkColor,
      primary: accentColor,
      secondary: accentColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: darkColor,
      ),
    ),
    dialogBackgroundColor: lightColor,
    appBarTheme: const AppBarTheme(
      color: lightColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: darkColor,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: darkColor,
      ),
      actionsIconTheme: IconThemeData(
        color: darkColor,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      shape: const CircleBorder(),
      fillColor: MaterialStateProperty.all<Color>(accentColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    // textTheme: lightTextTheme,
  );
  static final TextTheme lightTextTheme = const TextTheme().copyWith();

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: darkColor,
    scaffoldBackgroundColor: darkColor,
    backgroundColor: darkColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      onSurface: lightColor,
      primary: accentColor,
      secondary: accentColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: lightColor,
      ),
    ),
    dialogBackgroundColor: darkColor,
    appBarTheme: const AppBarTheme(
      color: darkColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: lightColor,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: accentColor,
      ),
      actionsIconTheme: IconThemeData(
        color: accentColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: accentColor,
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      shape: const CircleBorder(),
      fillColor: MaterialStateProperty.all<Color>(accentColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );

  // static final TextTheme darkTextTheme = const TextTheme().copyWith();
}
