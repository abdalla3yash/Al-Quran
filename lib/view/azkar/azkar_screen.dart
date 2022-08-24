import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/utils/themedata.dart';
import 'package:quran/view/azkar/azkar_item.dart';
import '../../controller/controllers/app_controller.dart';
import '../../controller/utils/file_operation.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  late AppController provider = Provider.of<AppController>(context);

  var azkarName = [];

  // ignore: prefer_typing_uninitialized_variables
  @override
  void initState() {
    getAzkarContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    AzkarItem(azkarName.elementAt(index), index + 1),
                itemCount: azkarName.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAzkarContent() async {
    FileOperations fileOperations = FileOperations();
    String data =
        await fileOperations.getDataFromFile('assets/content/azkar_names.txt');
    azkarName = data.split("\n");
    setState(() {});
  }
}
