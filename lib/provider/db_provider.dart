import 'package:flutter/material.dart';
import 'package:rumah_makan/data/local/database_helper.dart';

import '../data/model/restaurant.dart';

class DbProvider extends ChangeNotifier{
  List<Restaurant> _restaurant = [];
  late DatabaseHelper _databaseHelper;

  List<Restaurant> get restaurant => _restaurant;

  DbProvider(){
    _databaseHelper = DatabaseHelper();
    _getAllRestaurant();
  }

  void _getAllRestaurant() async {
    _restaurant = await _databaseHelper.getRestaurants();
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await _databaseHelper.insertRestaurant(restaurant);
    _getAllRestaurant();
  }

  void deleteRestaurant(String id) async {
    await _databaseHelper.deleteRestaurant(id);
    _getAllRestaurant();
  }
}