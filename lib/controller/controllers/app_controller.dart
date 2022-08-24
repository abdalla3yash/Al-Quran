import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran/controller/utils/constant.dart';
import 'package:quran/controller/utils/preferences.dart';
import 'package:quran/model/adhan_model.dart';
import 'package:http/http.dart' as http;

class AppController extends ChangeNotifier {
  late ThemeMode themeMode = ThemeMode.light;
  String currentLocale = 'ar';

  int valueHolder = 20;

  Future<AdhanModel> fetchAlbum() async {
    final response = await http
        .get(Uri.parse(AppConstant.BASE_URI + AppConstant.LOCATION_URI));
    if (response.statusCode == 200) {
      return AdhanModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

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
