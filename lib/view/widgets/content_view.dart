import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/file_operation.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/model/surah_model.dart';
import 'package:quran/view/setting/setting_screen.dart';

// ignore: must_be_immutable
class ContentView extends StatefulWidget {
  static const String routeName = "ContentView";
  int ayahNum = 0;

  ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late AppController provider;

  // ignore: prefer_typing_uninitialized_variables
  late var args;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppController>(context);
    args = ModalRoute.of(context)!.settings.arguments as SurahModel;

    return Scaffold(
      backgroundColor: provider.isDarkTheme()
          ? ThemeDataProvider.backgroundDarkColor
          : ThemeDataProvider.backgroundLightColor,
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SettingScreen(),
              SizedBox(
                height: 50,
                child: Image.asset(
                  "assets/sName/sname_${args.fileNumber}.png",
                  color: provider.isDarkTheme()
                      ? ThemeDataProvider.mainAppDarkColor
                      : ThemeDataProvider.mainAppLightColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: provider.isDarkTheme()
                      ? ThemeDataProvider.mainAppDarkColor
                      : ThemeDataProvider.mainAppLightColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            indent: 40,
            endIndent: 40,
            color:
                provider.isDarkTheme() ? Colors.white70 : Colors.grey.shade700,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder(
                  future: getContent(args.fileNumber),
                  builder: (BuildContext context, AsyncSnapshot<String> lines) {
                    if (lines.data != null) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 35,
                            child: Image.asset(
                              "assets/images/img_bismillah.png",
                              color: provider.isDarkTheme()
                                  ? ThemeDataProvider.textDarkThemeColor
                                  : ThemeDataProvider.textLightThemeColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                textScaleFactor: 1.3,
                                textAlign: TextAlign.justify,
                                lines.data!.toString(),
                                style: TextStyle(
                                  fontFamily: "quranFont",
                                  fontSize: Provider.of<AppController>(context,
                                          listen: true)
                                      .valueHolder
                                      .toDouble(),
                                  color: provider.isDarkTheme()
                                      ? ThemeDataProvider.textDarkThemeColor
                                      : ThemeDataProvider.textLightThemeColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<String> getContent(int NumOfSurah) async {
    FileOperations fileOperations = FileOperations();
    String data =
        await fileOperations.getDataFromFile('assets/txts/$NumOfSurah.txt');
    return formatContent(data);
  }

  String formatContent(String content) {
    ArabicNumbers arabicNumber = ArabicNumbers();

    if (args.isSurah) {
      // ignore: non_constant_identifier_names
      List<String> Surah = content.split('\n');
      String surahText = '';
      widget.ayahNum = 1;
      for (var line in Surah) {
        surahText += line;
        surahText += " (${arabicNumber.convert(widget.ayahNum.toString())}) ";
        widget.ayahNum++;
      }
      return surahText;
    } else {
      return content;
    }
  }
}
