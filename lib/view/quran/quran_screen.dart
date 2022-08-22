import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/file_operation.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/view/quran/surah_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuranScreen extends StatefulWidget {
  static const String routeName = "quran-screen";

  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  var surahsNames = [];
  var surahsVerses = [];
  late bool isRTL;

  @override
  void initState() {
    super.initState();
    getSurahContent();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    final TextDirection currentDirection = Directionality.of(context);

    isRTL = currentDirection == TextDirection.rtl;

    return Scaffold(
      backgroundColor: provider.isDarkTheme()
          ? ThemeDataProvider.backgroundDarkColor
          : ThemeDataProvider.backgroundLightColor,
      appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context).title,
            style: const TextStyle(
                color: ThemeDataProvider.textDarkThemeColor, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: provider.isDarkTheme()
              ? ThemeDataProvider.mainAppDarkColor
              : ThemeDataProvider.mainAppLightColor),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 15.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => SurahItem(
                name: surahsNames.elementAt(index),
                verse: surahsVerses.elementAt(index),
                fileNumber: index + 1,
                isRTL: isRTL,
                color: provider.isDarkTheme()
                    ? ThemeDataProvider.mainAppDarkColor
                    : ThemeDataProvider.mainAppLightColor,
              ),
              itemCount: surahsNames.length,
            ),
          ),
        ],
      ),
    );
  }

  getSurahContent() async {
    FileOperations fo = FileOperations();
    String data = await fo.getDataFromFile('assets/content/sura_names.txt');
    surahsNames = data.split("\n");
    data = await fo.getDataFromFile('assets/content/suras_nums.txt');
    surahsVerses = data.split("\n");
    setState(() {});
  }
}
