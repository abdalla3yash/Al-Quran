import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran/controller/utils/themedata.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = (Platform.isAndroid)
        ? const CircularProgressIndicator(
            color: ThemeDataProvider.mainAppColor,
          )
        : const CupertinoActivityIndicator(
            color: ThemeDataProvider.mainAppColor,
          );
    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}
