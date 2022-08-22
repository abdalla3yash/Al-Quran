import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/themedata.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = "setting-screen";

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late AppController provider = Provider.of<AppController>(context);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: provider.isDarkTheme()
            ? ThemeDataProvider.mainAppDarkColor
            : ThemeDataProvider.mainAppLightColor,
        size: 32,
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isDismissible: true,
            enableDrag: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            builder: (builder) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text(
                          //   provider.isDarkTheme()
                          //       ? AppLocalizations.of(context).light
                          //       : AppLocalizations.of(context).dark,
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     color: provider.isDarkTheme()
                          //         ? ThemeDataProvider.textDarkThemeColor
                          //         : ThemeDataProvider.textLightThemeColor,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              provider.isDarkTheme()
                                  ? provider.changeToLightTheme()
                                  : provider.changeToDarkTheme();
                            },
                            icon: provider.isDarkTheme()
                                ? const Icon(Icons.light_mode, size: 32)
                                : const Icon(Icons.dark_mode, size: 32),
                          ),
                          IconButton(
                            onPressed: () {
                              provider.isEnglish()
                                  ? provider.changeLanguage('ar')
                                  : provider.changeLanguage('en');
                            },
                            icon: Icon(Icons.language,
                                size: 32,
                                color: provider.isEnglish()
                                    ? ThemeDataProvider.mainAppDarkColor
                                    : ThemeDataProvider.mainAppLightColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Slider(
                        activeColor: provider.isDarkTheme()
                            ? ThemeDataProvider.mainAppDarkColor
                            : ThemeDataProvider.mainAppLightColor,
                        value: Provider.of<AppController>(context, listen: true)
                            .valueHolder
                            .toDouble(),
                        min: 14,
                        max: 44,
                        label:
                            '${Provider.of<AppController>(context, listen: true).valueHolder.round()}',
                        onChanged: (double newValue) {
                          setState(() {
                            Provider.of<AppController>(context, listen: false)
                                .saveFontSize(newValue.round());
                          });
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '${newValue.round()}';
                        }),
                  ],
                ),
              );
            });
      },
    );
  }
}
