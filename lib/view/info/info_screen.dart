import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  static const String routeName = "infoview";

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ArabicNumbers arabicNumber = ArabicNumbers();

  _launchURL(int i) async {
    List<String> urls = [
      'https://www.linkedin.com/in/abdalla-ayash/',
      'https://github.com/abdalla3yash',
      'https://www.facebook.com/abdalla.3yash',
      "https://wa.me/201091032414",
      "https://ayash.netlify.app/",
      "https://twitter.com/3yashh/",
    ];
    // ignore: deprecated_member_use
    if (await canLaunch(urls[i])) {
      // ignore: deprecated_member_use
      await launch(urls[i]);
    } else {
      throw 'Could not launch $urls[i]';
    }
  }

  @override
  Widget build(BuildContext context) {
    late AppController provider = Provider.of<AppController>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: MediaQuery.of(context).size.width > 1000
                  ? provider.isDarkTheme()
                      ? const AssetImage(
                          ThemeDataProvider.imageBackgroundDarkWeb,
                        )
                      : const AssetImage(
                          ThemeDataProvider.imageBackgroundLightWeb,
                        )
                  : provider.isDarkTheme()
                      ? const AssetImage(
                          ThemeDataProvider.imageBackgroundDark,
                        )
                      : const AssetImage(
                          ThemeDataProvider.imageBackgroundLight),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: ThemeDataProvider.mainAppColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: ThemeDataProvider.mainAppColor,
                        radius: MediaQuery.of(context).size.width * 0.12,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
                          child: Image.asset(
                            "assets/images/quran.png",
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "`وَأَنَّ سَعْيَهُۥ سَوْفَ يُرَىٰ`",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            fontFamily: "quranFont",
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            settings(context),
            const SizedBox(height: 10),
            about(context),
            const SizedBox(height: 10),
            developers(context),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                provider.isEnglish()
                    ? "Ayash 2022 © All Rights Reserved"
                    : arabicNumber.convert("جميع الحقوق محفوظه © عياش 2022"),
                style: TextStyle(
                  fontSize: 14,
                  color: provider.isDarkTheme()
                      ? ThemeDataProvider.textDarkThemeColor
                      : ThemeDataProvider.textLightThemeColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                provider.isEnglish()
                    ? "1.0.0 version"
                    : arabicNumber.convert("1.0.0 إصدار"),
                style: TextStyle(
                  fontSize: 12,
                  color: provider.isDarkTheme()
                      ? ThemeDataProvider.textDarkThemeColor
                      : ThemeDataProvider.textLightThemeColor,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget developers(BuildContext context) {
    late AppController provider = Provider.of<AppController>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              color: ThemeDataProvider.mainAppColor,
              size: 24,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "Developers" : "المطورون",
          style: TextStyle(
            fontSize: 24,
            color: provider.isDarkTheme()
                ? ThemeDataProvider.textDarkThemeColor
                : ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: provider.isEnglish()
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      provider.isEnglish() ? "Abdalla Ayash" : "عبدالله عياش",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: "quranFont",
                          color: ThemeDataProvider.mainAppColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        provider.isEnglish()
                            ? ". Flutter Developer"
                            : ". مبرمج تطبيقات",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "quranFont",
                          color: provider.isDarkTheme()
                              ? ThemeDataProvider.textDarkThemeColor
                              : ThemeDataProvider.textLightThemeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  textAlign: TextAlign.justify,
                  provider.isEnglish()
                      ? 'Experienced Information Technology Specialist with a demonstrated history of working in the computer software industry. Skilled in Mobile Application Development, IT Service Management, and Volunteering'
                      : "متخصص في تكنولوجيا المعلومات من ذوي الخبرة ولدي تاريخ مثبت في العمل في صناعة برامج الكمبيوتر. ماهر في تطوير تطبيقات الهاتف المحمول، وإدارة خدمات تكنولوجيا المعلومات ، والعمل التطوعي",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: provider.isDarkTheme()
                            ? ThemeDataProvider.textDarkThemeColor
                            : ThemeDataProvider.textLightThemeColor,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchURL(0);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      color: Color(0xff0E76A8),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(1);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      color: provider.isDarkTheme()
                          ? ThemeDataProvider.textDarkThemeColor
                          : const Color(0xff171515),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(4);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.bugs,
                      color: Color(0xFF89dad0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(3);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Color(0xff25d366),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(2);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color(0xff3b5998),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(5);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Color(0xff1DA1F2),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget about(BuildContext context) {
    late AppController provider = Provider.of<AppController>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.info_outline,
              color: ThemeDataProvider.mainAppColor,
              size: 24,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "About" : "عن التطبيق",
          style: TextStyle(
            fontSize: 24,
            color: provider.isDarkTheme()
                ? ThemeDataProvider.textDarkThemeColor
                : ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: provider.isEnglish()
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  provider.isEnglish() ? "َAl-Quran" : " القرآن الكريم",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    fontFamily: "quranFont",
                    color: provider.isDarkTheme()
                        ? ThemeDataProvider.textDarkThemeColor
                        : ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  textAlign: TextAlign.justify,
                  provider.isEnglish()
                      ? 'The application of the Holy Qur’an helps you to read the surahs and verses wherever you go and remember the times of prayer with determining the direction of the qiblah. There is also our Holy Qur’an radio station. We also give you the possibility to glorify God and display hadiths and remembrances.'
                      : "تطبيق القرآن الكريم يساعدك على قرآه السور والايات أينما ذهبت وتذكر مواعيد الصلاه مع تحديد اتجاه القبله كما أنه يوجد اذاعه القرآن الكريم الخاصه بنا كما نتيح لكم امكانيه تسبيح الله وعرض الاحاديث والاذكار",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: provider.isDarkTheme()
                            ? ThemeDataProvider.textDarkThemeColor
                            : ThemeDataProvider.textLightThemeColor,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget settings(BuildContext context) {
    late AppController provider = Provider.of<AppController>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.settings,
              color: ThemeDataProvider.mainAppColor,
              size: 24,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "Settings" : "الاعدادات",
          style: TextStyle(
            fontSize: 24,
            color: provider.isDarkTheme()
                ? ThemeDataProvider.textDarkThemeColor
                : ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: provider.isEnglish()
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "كَلا إِنَّ مَعِيَ رَبِّي سَيَهْدِينِ ",
                  style: TextStyle(
                    fontSize: Provider.of<AppController>(context, listen: true)
                        .valueHolder
                        .toDouble(),
                    fontWeight: FontWeight.w400,
                    fontFamily: "quranFont",
                    color: provider.isDarkTheme()
                        ? ThemeDataProvider.textDarkThemeColor
                        : ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
              Slider(
                  activeColor: ThemeDataProvider.mainAppColor,
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isEnglish() ? "Language" : "اللغه",
                        style: TextStyle(
                            fontSize: 20,
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor),
                      ),
                      CupertinoSwitch(
                        value: provider.isEnglish() ? true : false,
                        onChanged: (value) {
                          setState(() {
                            provider.isEnglish()
                                ? provider.changeLanguage('ar')
                                : provider.changeLanguage('en');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isEnglish() ? "Dark Mode" : "الوضع الليلي",
                        style: TextStyle(
                            fontSize: 20,
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor),
                      ),
                      CupertinoSwitch(
                        value: provider.isDarkTheme() ? true : false,
                        onChanged: (value) {
                          setState(() {
                            provider.isDarkTheme()
                                ? provider.changeToLightTheme()
                                : provider.changeToDarkTheme();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
