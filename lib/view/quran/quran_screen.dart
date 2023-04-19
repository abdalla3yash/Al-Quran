import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/file_operation.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/model/adhan_model.dart';
import 'package:quran/controller/utils/loading_indicator.dart';
import 'package:quran/view/info/info_screen.dart';
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
  Future<AdhanModel>? futureAlbum;
  ArabicNumbers arabicNumber = ArabicNumbers();

  @override
  void initState() {
    super.initState();
    getSurahContent();
    futureAlbum =
        Provider.of<AppController>(context, listen: false).fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    final TextDirection currentDirection = Directionality.of(context);

    isRTL = currentDirection == TextDirection.rtl;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: MediaQuery.of(context).size.width > 1000
                  ? provider.isDarkTheme()
                      ? const AssetImage(
                          ThemeDataProvider.imageBackgroundDarkWeb)
                      : const AssetImage(
                          ThemeDataProvider.imageBackgroundLightWeb)
                  : provider.isDarkTheme()
                      ? const AssetImage(ThemeDataProvider.imageBackgroundDark)
                      : const AssetImage(
                          ThemeDataProvider.imageBackgroundLight),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppLocalizations.of(context)!.hello,
                      style: TextStyle(
                        color: provider.isDarkTheme()
                            ? ThemeDataProvider.textDarkThemeColor
                            : ThemeDataProvider.textLightThemeColor,
                        fontSize: 24,
                        fontFamily: "quranFont",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, InfoScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        color: ThemeDataProvider.mainAppColor,
                        size: 32,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                FutureBuilder<AdhanModel>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage(
                              "assets/images/time.jpg",
                            ),
                            colorFilter: ColorFilter.mode(
                                Colors.grey.withOpacity(0.9), BlendMode.darken),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isRTL
                                        ? snapshot
                                            .data!.data!.date!.hijri!.month!.ar!
                                        : snapshot.data!.data!.date!.hijri!
                                            .month!.en!,
                                    style: const TextStyle(
                                      color: ThemeDataProvider.mainAppColor,
                                      fontSize: 16,
                                      fontFamily: "quranFont",
                                    ),
                                  ),
                                  Text(
                                    isRTL
                                        ? snapshot.data!.data!.date!.hijri!
                                            .weekday!.ar!
                                        : snapshot.data!.data!.date!.hijri!
                                            .weekday!.en!,
                                    style: const TextStyle(
                                      color:
                                          ThemeDataProvider.textDarkThemeColor,
                                      fontSize: 16,
                                      fontFamily: "quranFont",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                isRTL
                                    ? arabicNumber.convert(
                                        snapshot.data!.data!.date!.hijri!.date!,
                                      )
                                    : snapshot.data!.data!.date!.hijri!.date!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 26),
                              ),
                            ),
                            const Spacer(),
                            const Spacer(),
                            const Spacer(),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const LoadingIndicator();
                  },
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: FutureBuilder<AdhanModel>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> names = [
                          AppLocalizations.of(context)!.fajr,
                          AppLocalizations.of(context)!.sunrise,
                          AppLocalizations.of(context)!.duhr,
                          AppLocalizations.of(context)!.asr,
                          AppLocalizations.of(context)!.maghrib,
                          AppLocalizations.of(context)!.isha,
                          AppLocalizations.of(context)!.imsak,
                          AppLocalizations.of(context)!.midnight,
                          AppLocalizations.of(context)!.firsthird,
                          AppLocalizations.of(context)!.lasthird,
                        ];
                        List<String> times = [
                          snapshot.data!.data!.timings!.fajr!,
                          snapshot.data!.data!.timings!.sunrise!,
                          snapshot.data!.data!.timings!.dhuhr!,
                          snapshot.data!.data!.timings!.asr!,
                          snapshot.data!.data!.timings!.maghrib!,
                          snapshot.data!.data!.timings!.isha!,
                          snapshot.data!.data!.timings!.imsak!,
                          snapshot.data!.data!.timings!.midnight!,
                          snapshot.data!.data!.timings!.firstthird!,
                          snapshot.data!.data!.timings!.lastthird!,
                        ];
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                    itemCount: names.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: 80.0,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                names[i],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                isRTL
                                                    ? arabicNumber.convert(
                                                        times[i],
                                                      )
                                                    : times[i],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ThemeDataProvider
                                                      .mainAppColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ]);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const LoadingIndicator();
                    },
                  ),
                ),
              ],
            ),
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
                  color: ThemeDataProvider.mainAppColor,
                ),
                itemCount: surahsNames.length,
              ),
            ),
          ],
        ),
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
