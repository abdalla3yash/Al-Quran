import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/preferences.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/view/landing_screen.dart';
import 'package:quran/view/onBoarding/onBoarding_screen.dart';
import 'package:quran/view/qibla/qibla.dart';
import 'package:quran/view/quran/quran_screen.dart';
import 'package:quran/view/setting/setting_screen.dart';
import 'package:quran/view/widgets/azkar_and_hadith_view.dart';
import 'package:quran/view/widgets/content_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (buildContext) => AppController(),
        builder: (buildContext, widget) {
          final provider = Provider.of<AppController>(buildContext);
          provider.themeMode = Preferences.getThemePreference();
          return MaterialApp(
            themeMode: provider.themeMode,
            darkTheme: ThemeDataProvider.darkTheme,
            theme: ThemeDataProvider.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale.fromSubtags(languageCode: Preferences.getLanguage()),
            // home: const QiblaScreen(),
            debugShowCheckedModeBanner: false,
            initialRoute: initScreen == 0 || initScreen == null
                ? onBoardingPage.routeName
                : LandingScreen.routeName,
            routes: {
              onBoardingPage.routeName: (context) => const onBoardingPage(),
              LandingScreen.routeName: (context) => const LandingScreen(),
              QuranScreen.routeName: (context) => const QuranScreen(),
              ContentView.routeName: (context) => ContentView(),
              AzkarandHadithView.routeName: (context) => AzkarandHadithView(),
              SettingScreen.routeName: (context) => const SettingScreen(),
            },
          );
        });
  }
}
