import 'package:flutter/material.dart';
import 'package:quran/controller/utils/themedata.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const widget = CircularProgressIndicator(
      color: ThemeDataProvider.mainAppColor,
    );

    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}
