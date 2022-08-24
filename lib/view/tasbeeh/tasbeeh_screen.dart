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
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tasbeeh,
            style: const TextStyle(
                color: ThemeDataProvider.textDarkThemeColor, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: ThemeDataProvider.mainAppColor),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: provider.isDarkTheme()
                  ? const AssetImage("assets/images/bdark.png")
                  : const AssetImage("assets/images/blight.png"),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              tasbeehButtonLabel,
              textScaleFactor: 1.5,
              style: TextStyle(
                  color: ThemeDataProvider.mainAppColor,
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
                    radius: MediaQuery.of(context).size.height * 0.2,
                    backgroundColor: _tasbeehCounter.isOdd
                        ? const Color.fromARGB(255, 47, 228, 161)
                        : ThemeDataProvider.mainAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
