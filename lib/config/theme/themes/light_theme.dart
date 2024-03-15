part of '../theme.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light, // Giving a default light theme to our app
  useMaterial3: true,
  fontFamily: "SofiaPro",
  scaffoldBackgroundColor: white,
  colorScheme: const ColorScheme.light(
    onPrimary: white,
    primary: dark,
    secondary: red,
  ),
);
