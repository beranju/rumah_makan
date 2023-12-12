import 'dart:convert';

/// name : "Paket rosemary"

Foods foodsFromJson(String str) => Foods.fromJson(json.decode(str));
String foodsToJson(Foods data) => json.encode(data.toJson());
class Foods {
  Foods({
      String? name,}){
    _name = name;
}

  Foods.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}