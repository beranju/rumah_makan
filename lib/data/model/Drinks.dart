import 'dart:convert';

/// name : "Es krim"

Drinks drinksFromJson(String str) => Drinks.fromJson(json.decode(str));
String drinksToJson(Drinks data) => json.encode(data.toJson());
class Drinks {
  Drinks({
      String? name,}){
    _name = name;
}

  Drinks.fromJson(dynamic json) {
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