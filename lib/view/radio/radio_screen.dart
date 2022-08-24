import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/utils/themedata.dart';
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
  late Future<RadioResponse> radioStations;
  late String radioUrl;
  bool isPlaying = false;
  RadioPlayer radioPlayer = RadioPlayer();
  List<String>? metadata;

  // ignore: prefer_typing_uninitialized_variables
  static int index = 0;
  String arabicRadio = "https://api.mp3quran.net/radios/radio_arabic.json";
  String englishRadio = "https://api.mp3quran.net/radios/radio_english.json";

  @override
  void initState() {
    super.initState();
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
              image: provider.isDarkTheme()
                  ? const AssetImage("assets/images/bdark.png")
                  : const AssetImage("assets/images/blight.png"),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 30,
                                  color: provider.isDarkTheme()
                                      ? ThemeDataProvider.textDarkThemeColor
                                      : ThemeDataProvider.textLightThemeColor,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      isPlaying == true ? false : true;
                                    },
                                  );
                                  play(stations.data!.radios
                                      .elementAt(index)
                                      .radio_url);
                                },
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
                        Text(
                          convertUTF8(
                              stations.data!.radios.elementAt(index).name),
                          style: TextStyle(
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  } else if (stations.hasError) {
                    return const Text("Error loading radio");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void play(String radioStation) {
    radioPlayer.setChannel(title: "", url: radioStation);
    isPlaying = !isPlaying;
    isPlaying ? radioPlayer.play() : radioPlayer.pause();
    radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });
  }

  void next(String radioStation, int length) {
    index == length ? index : index++;
    radioPlayer.setChannel(title: "", url: radioStation);
    setState(() {});
  }

  void previous(String radioStation) {
    index == 0 ? index : index--;
    radioPlayer.setChannel(title: "", url: radioStation);
    setState(() {});
  }
}

String convertUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}
