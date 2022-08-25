import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/controller/utils/loading_indicator.dart';
import 'package:radio_player/radio_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controller/controllers/app_controller.dart';
import '../../controller/controllers/radio_controller.dart';

class RadioScreen extends StatefulWidget {
  static const String routeName = "radio-screen";

  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  late Future<RadioResponse> radioStations;
  late String radioUrl;

  // ignore: prefer_typing_uninitialized_variables
  static int index = 0;
  String arabicRadio = "https://api.mp3quran.net/radios/radio_arabic.json";
  String englishRadio = "https://api.mp3quran.net/radios/radio_english.json";
  @override
  void initState() {
    super.initState();
    play();
  }

  late AppController provider = Provider.of<AppController>(context);

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isLTR = currentDirection == TextDirection.ltr;
    radioStations =
        isLTR ? getRadioStations(englishRadio) : getRadioStations(arabicRadio);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).radio,
          style: TextStyle(
            color: provider.isDarkTheme()
                ? ThemeDataProvider.textDarkThemeColor
                : ThemeDataProvider.textLightThemeColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeDataProvider.mainAppColor,
      ),
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
            Center(
              child: FutureBuilder<RadioResponse>(
                future: radioStations,
                builder: (context, stations) {
                  if (stations.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          AppLocalizations.of(context).radio,
                          style: TextStyle(
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Lottie.asset('assets/images/radio.json')),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          convertUTF8(
                              stations.data!.radios.elementAt(index).name),
                          style: TextStyle(
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Transform(
                                transform:
                                    Matrix4.rotationY(isLTR ? math.pi : 0),
                                alignment: AlignmentDirectional.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fast_forward_sharp,
                                    size: 30,
                                    color: provider.isDarkTheme()
                                        ? ThemeDataProvider.textDarkThemeColor
                                        : ThemeDataProvider.textLightThemeColor,
                                  ),
                                  onPressed: () {
                                    next(
                                      stations.data!.radios
                                          .elementAt(index)
                                          .radio_url,
                                      stations.data!.radios.length,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: CircleAvatar(
                                maxRadius: 30,
                                minRadius: 20,
                                backgroundColor: ThemeDataProvider.mainAppColor,
                                child: IconButton(
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 30,
                                    color: provider.isDarkTheme()
                                        ? ThemeDataProvider.textDarkThemeColor
                                        : ThemeDataProvider.textLightThemeColor,
                                  ),
                                  onPressed: () {
                                    isPlaying
                                        ? _radioPlayer.pause()
                                        : _radioPlayer.play();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Transform(
                                transform:
                                    Matrix4.rotationY(isLTR ? math.pi : 0),
                                alignment: AlignmentDirectional.center,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    size: 30,
                                    color: provider.isDarkTheme()
                                        ? ThemeDataProvider.textDarkThemeColor
                                        : ThemeDataProvider.textLightThemeColor,
                                  ),
                                  onPressed: () {
                                    previous(stations.data!.radios
                                        .elementAt(index)
                                        .radio_url);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  } else if (stations.hasError) {
                    return const Text("Error loading radio");
                  }
                  return const LoadingIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void play() {
    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });
    _radioPlayer.setChannel(
      title: "Radio Quran",
      url: "https://qurango.net/radio/sahabah",
      imagePath: "assets/images/time.jpg",
    );
  }

  void next(String radioStation, int length) {
    index == length ? index : index++;
    _radioPlayer.setChannel(
      title: "Radio Quran",
      url: radioStation,
      imagePath: "assets/images/time.jpg",
    );

    setState(() {});
  }

  void previous(String radioStation) {
    index == 0 ? index : index--;
    _radioPlayer.setChannel(
      title: "Radio Quran",
      url: radioStation,
      imagePath: "assets/images/time.jpg",
    );
    setState(() {});
  }
}

String convertUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}
