import 'package:flutter/material.dart';

class ThemeDataProvider {
  static const mainAppDarkColor = Color.fromARGB(255, 39, 153, 144);
  static const primaryDarkThemeColor = Color.fromARGB(255, 88, 88, 88);
  static const textDarkThemeColor = Colors.white;
  static const backgroundDarkColor = Color.fromARGB(255, 55, 57, 58);

  static const mainAppLightColor = Color(0xFF0ec683);
  static const textLightThemeColor = Color.fromARGB(255, 58, 58, 58);
  static const backgroundLightColor = Colors.white;
  static const primaryLightThemeColor = Colors.white;

  static final lightTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white, modalBackgroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: textLightThemeColor)),
    // textTheme: TextTheme(
    //   bodyText1: const TextStyle(
    //     color: secondaryLightThemeColor,
    //     fontSize: 25,
    //     fontWeight: FontWeight.normal,
    //     fontFamily: "Sultann",
    //   ),
    //   headline1: const TextStyle(
    //     color: secondaryLightThemeColor,
    //     fontSize: 25,
    //     fontFamily: "ElMessiri",
    //   ),
    //   headline2: const TextStyle(
    //     color: secondaryLightThemeColor,
    //     fontSize: 25,
    //     fontFamily: "ElMessiri",
    //   ),
    //   bodyText2: const TextStyle(
    //       color: secondaryLightThemeColor,
    //       fontFamily: "ElMessiri",
    //       // fontFamily: "DecoType",
    //       height: 2),
    //   headline3: TextStyle(
    //     color: Colors.white.withOpacity(1),
    //     fontFamily: "Sultann",
    //     fontSize: 20,
    //     fontWeight: FontWeight.normal,
    //   ),
    // ),
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
    // textTheme: const TextTheme(
    //   bodyText1: TextStyle(
    //     color: Colors.white,
    //     fontSize: 25,
    //     fontFamily: "Sultann",
    //     fontWeight: FontWeight.normal,
    //   ),
    //   headline1: TextStyle(
    //     color: Colors.white,
    //     fontSize: 25,
    //     fontFamily: "ElMessiri",
    //   ),
    //   headline2: TextStyle(
    //     color: primaryDarkThemeColor,
    //     fontSize: 25,
    //     fontFamily: "ElMessiri",
    //   ),
    //   bodyText2: TextStyle(
    //       fontSize: 20,
    //       color: primaryDarkThemeColor,
    //       fontFamily: "ElMessiri",
    //       height: 2),
    //   headline3: TextStyle(
    //     color: Colors.black,
    //     fontFamily: "Sultann",
    //     fontWeight: FontWeight.normal,
    //   ),
    // ),
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
