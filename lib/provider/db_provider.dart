import 'package:flutter/material.dart';
import 'package:rumah_makan/data/local/database_helper.dart';

import '../data/model/restaurant.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  bool _isFavorite = false;
  late DatabaseHelper _databaseHelper;

  List<Restaurant> get restaurant => _restaurant;

  bool get isFavorite => _isFavorite;

  DbProvider() {
    _databaseHelper = DatabaseHelper();
    getAllRestaurant();
  }

  void getAllRestaurant() async {
    _restaurant = await _databaseHelper.getRestaurants();
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await _databaseHelper.insertRestaurant(restaurant);
    checkIsFavorite(restaurant.id);
  }

  void checkIsFavorite(String id) async {
    _isFavorite = await _databaseHelper.isFavorite(id);
    notifyListeners();
  }

  void deleteRestaurant(String id) async {
    await _databaseHelper.deleteRestaurant(id);
    checkIsFavorite(id);
    getAllRestaurant();
  }
}
