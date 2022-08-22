import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/view/widgets/azkar_and_hadith_view.dart';
import '../../model/surah_model.dart';

// ignore: must_be_immutable
class AzkarItem extends StatelessWidget {
  String name;
  int fileNumber;

  AzkarItem(this.name, this.fileNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    ArabicNumbers arabicNumber = ArabicNumbers();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AzkarandHadithView.routeName,
            arguments: SurahModel(name, (fileNumber + 2000), false));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: provider.isDarkTheme()
                            ? ThemeDataProvider.mainAppDarkColor
                            : ThemeDataProvider.mainAppLightColor,
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        color: provider.isDarkTheme()
                            ? ThemeDataProvider.textDarkThemeColor
                            : ThemeDataProvider.textLightThemeColor,
                      ),
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
