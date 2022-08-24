import 'package:flutter/material.dart';

class ThemeDataProvider {
  // static const mainAppDarkColor = Color.fromARGB(255, 39, 153, 144);
  static const primaryDarkThemeColor = Color.fromARGB(255, 88, 88, 88);
  static const textDarkThemeColor = Colors.white;
  static const backgroundDarkColor = Color.fromARGB(255, 55, 57, 58);

  static const imageBackgroundLight = "assets/images/blight.png";
  static const imageBackgroundDark = "assets/images/bdark.png";
  static const imageBackgroundLightWeb = "assets/images/blight-web.png";
  static const imageBackgroundDarkWeb = "assets/images/bdark-web.png";

  static const mainAppColor = Color(0xFF0ec683);
  static const textLightThemeColor = Color.fromARGB(255, 58, 58, 58);
  static const backgroundLightColor = Colors.white;
  static const primaryLightThemeColor = Colors.white;

  static final lightTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white, modalBackgroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: textLightThemeColor)),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: primaryLightThemeColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryLightThemeColor),
        minimumSize: MaterialStateProperty.all(const Size(150, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(
              color: primaryLightThemeColor,
            ),
          ),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: primaryDarkThemeColor,
      modalBackgroundColor: primaryDarkThemeColor,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: textDarkThemeColor,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: primaryDarkThemeColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryDarkThemeColor),
        minimumSize: MaterialStateProperty.all(const Size(150, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(
              color: primaryDarkThemeColor,
            ),
          ),
        ),
      ),
    ),
  );
}
