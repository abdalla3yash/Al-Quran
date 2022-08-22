import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controller/controllers/app_controller.dart';

class TasbeehScreen extends StatefulWidget {
  static const String routeName = "tasbeeh-screen";

  const TasbeehScreen({Key? key}) : super(key: key);

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  late AppController provider = Provider.of<AppController>(context);
  String tasbeehButtonLabel = 'سبحان الله';
  int _tasbeehCounter = 0;

  void _changeTasbeehButtonDisplay() {
    if (tasbeehButtonLabel == 'سبحان الله') {
      tasbeehButtonLabel = 'الحمد لله';
    } else if (tasbeehButtonLabel == 'الحمد لله') {
      tasbeehButtonLabel = "لا إله إلا الله";
    } else if (tasbeehButtonLabel == "لا إله إلا الله") {
      tasbeehButtonLabel = 'الله اكبر';
    } else if (tasbeehButtonLabel == 'الله اكبر') {
      tasbeehButtonLabel = "لا حول ولا قوة إلا بالله";
    } else {
      tasbeehButtonLabel = 'سبحان الله';
    }
  }

  void _incrementTasbeehCounter() {
    setState(() {
      if (_tasbeehCounter == 33) {
        _tasbeehCounter = 0;
        _changeTasbeehButtonDisplay();
      } else {
        _tasbeehCounter++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: provider.isDarkTheme()
          ? ThemeDataProvider.backgroundDarkColor
          : ThemeDataProvider.backgroundLightColor,
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tasbeeh,
            style: const TextStyle(
                color: ThemeDataProvider.textDarkThemeColor, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: provider.isDarkTheme()
              ? ThemeDataProvider.mainAppDarkColor
              : ThemeDataProvider.mainAppLightColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            tasbeehButtonLabel,
            textScaleFactor: 1.5,
            style: TextStyle(
                color: provider.isDarkTheme()
                    ? ThemeDataProvider.mainAppDarkColor
                    : ThemeDataProvider.mainAppLightColor,
                fontSize: provider.valueHolder.toDouble()),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            '$_tasbeehCounter ',
            textScaleFactor: 1.5,
            style: TextStyle(
                color: provider.isDarkTheme() ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: provider.valueHolder.toDouble()),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          GestureDetector(
            onTap: () {
              _incrementTasbeehCounter();
            },
            child: Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.35,
                  backgroundColor: _tasbeehCounter.isOdd
                      ? ThemeDataProvider.mainAppDarkColor
                      : ThemeDataProvider.mainAppLightColor),
            ),
          ),
        ],
      ),
    );
  }
}
