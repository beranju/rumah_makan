import 'dart:convert';

import 'Drinks.dart';
import 'Foods.dart';

Menus menusFromJson(String str) => Menus.fromJson(json.decode(str));

String menusToJson(Menus data) => json.encode(data.toJson());

class Menus {
  Menus({
    List<Foods>? foods,
    List<Drinks>? drinks,
  }) {
    _foods = foods;
    _drinks = drinks;
  }

  Menus.fromJson(dynamic json) {
    if (json['foods'] != null) {
      _foods = [];
      json['foods'].forEach((v) {
        _foods?.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      _drinks = [];
      json['drinks'].forEach((v) {
        _drinks?.add(Drinks.fromJson(v));
      });
    }
  }

  List<Foods>? _foods;
  List<Drinks>? _drinks;

  List<Foods>? get foods => _foods;

  List<Drinks>? get drinks => _drinks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_foods != null) {
      map['foods'] = _foods?.map((v) => v.toJson()).toList();
    }
    if (_drinks != null) {
      map['drinks'] = _drinks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
