import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/model/surah_model.dart';
import 'package:quran/view/widgets/content_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class SurahItem extends StatelessWidget {
  final String name, verse;
  final int fileNumber;
  final Color color;
  bool isRTL;
  SurahItem(
      {Key? key,
      required this.name,
      required this.verse,
      required this.fileNumber,
      required this.color,
      required this.isRTL})
      : super(key: key);
  double sizeNumbering = 40;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    ArabicNumbers arabicNumber = ArabicNumbers();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ContentView.routeName,
            arguments: SurahModel(name, fileNumber, true));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: sizeNumbering,
                          height: sizeNumbering,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              arabicNumber.convert(fileNumber.toString()),
                              style: const TextStyle(
                                fontSize: 18,
                                color: ThemeDataProvider.textDarkThemeColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 40,
                          child: Image.asset(
                            "assets/sName/sname_$fileNumber.png",
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          provider.isEnglish()
                              ? "$verse ${AppLocalizations.of(context)!.verse}"
                              : "${arabicNumber.convert(verse)} ${AppLocalizations.of(context)!.verse}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: color),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: provider.isDarkTheme()
                    ? Colors.white70
                    : Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
