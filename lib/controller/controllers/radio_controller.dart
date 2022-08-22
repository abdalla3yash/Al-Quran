import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/model/radio_model.dart';

class RadioResponse {
  List<Radio> radios;

  RadioResponse.fromJsonMap(Map<String, dynamic> map)
      : radios = List<Radio>.from(
          map["radios"].map(
            (it) => Radio.fromJsonMap(it),
          ),
        );
}

Future<RadioResponse> getRadioStations(String api) async {
  final uri = Uri.parse(api);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return RadioResponse.fromJsonMap(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load data");
  }
}
