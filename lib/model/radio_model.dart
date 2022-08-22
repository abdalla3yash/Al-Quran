class Radio {
  String name;
  // ignore: non_constant_identifier_names
  String radio_url;

  Radio(this.name, this.radio_url);

  Radio.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        radio_url = map["radio_url"];
}
