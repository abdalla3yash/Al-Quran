import 'package:flutter/material.dart';
import 'package:quran/controller/utils/preferences.dart';

class AppController extends ChangeNotifier {
  late ThemeMode themeMode = ThemeMode.light;
  String currentLocale = 'ar';

  int valueHolder = 20;

  void saveFontSize(int newValue) {
    valueHolder = newValue;
    notifyListeners();
  }

  void changeToLightTheme() {
    themeMode = ThemeMode.light;
    Preferences.saveThemePreference(themeMode);
    notifyListeners();
  }

  void changeToDarkTheme() {
    themeMode = ThemeMode.dark;
    Preferences.saveThemePreference(themeMode);
    notifyListeners();
  }

  bool isDarkTheme() {
    return themeMode == ThemeMode.dark;
  }

  bool isEnglish() {
    return currentLocale == 'en';
  }

  void changeLanguage(String lang) {
    currentLocale = lang;
    Preferences.setLanguage(currentLocale);
    notifyListeners();
  }
}
