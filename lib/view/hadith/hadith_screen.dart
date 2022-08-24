import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/controller/controllers/app_controller.dart';
import 'package:quran/view/hadith/hadith_item.dart';
import '../../controller/utils/file_operation.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  late AppController provider = Provider.of<AppController>(context);
  var hadethName = [];

  // ignore: prefer_typing_uninitialized_variables
  late var borderColor;
  @override
  void initState() {
    getHadethContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    HadithItem(hadethName.elementAt(index), index + 1),
                itemCount: hadethName.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getHadethContent() async {
    FileOperations fileOperations = FileOperations();
    String data =
        await fileOperations.getDataFromFile('assets/content/hades_names.txt');
    hadethName = data.split("\n");
    setState(() {});
  }
}
