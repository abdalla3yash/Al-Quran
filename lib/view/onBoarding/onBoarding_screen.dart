import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/view/landing_screen.dart';

// ignore: camel_case_types
class onBoardingPage extends StatelessWidget {
  static const String routeName = "onBoarding-screen";

  const onBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "'قَالَ  أَسْلَمْتُ  لِرَبِّ  الْعَالَمِينَ'",
          body:
              'تطبيق القرآن يساعدك على قراءه القرآن وتدبر معانيه وكعرفه مواقيت الصلاه وتسبيح الله وقرآه الاذكاء والادعيه أينما ذهبت',
          image: buildImage('assets/images/onboarding1.png'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: "'وَحَيْثُ مَا كُنتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ ۗ'",
          body: 'مواقيت الصلاه تساعدك على تذكر اوقات الصلاه بسهوله تامه',
          image: buildImage('assets/images/onboarding3.jpg'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title:
              "'فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚإِنَّهُ كَانَ تَوَّابً'",
          body: 'هنالك الكثير من الاحاديث والادعيه والاذكار والتسبيح',
          image: buildImage('assets/images/onboarding2.png'),
          decoration: buildDecoration(),
        ),
      ],
      next: const Icon(
        Icons.navigate_before,
        size: 40,
        color: ThemeDataProvider.mainAppColor,
      ),
      done: const Text('Done',
          style:
              TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20),
      ),
      onSkip: () => goToHome(context),
      dotsDecorator: getDotDecoration(),
      animationDuration: 1000,
      globalBackgroundColor: Colors.white,
      rtl: true,
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.grey,
      size: const Size(10, 10),
      activeColor: ThemeDataProvider.mainAppColor,
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  void goToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LandingScreen()));

  Widget buildImage(String path) => Center(child: Image.asset(path));

  PageDecoration buildDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "quranFont",
            color: ThemeDataProvider.mainAppColor),
        bodyTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: "quranFont",
        ),
        bodyAlignment: Alignment.bottomCenter,
        imageAlignment: Alignment.bottomCenter,
        pageColor: Colors.white,
        imagePadding: EdgeInsets.only(
          top: 50,
          left: 10,
          right: 10,
        ),
      );
}
