class Voice {
  final String name;
  final String gender;
  final double pitch;
  final List<String> languageCodes;

  Voice(this.name, this.gender, this.languageCodes, this.pitch);

  static List<Voice> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList.map((v) {
      return Voice(v['name'], v['ssmlGender'], List<String>.from(v['languageCodes']), v['pitch']);
    }).toList();
  }

}