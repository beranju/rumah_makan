import 'package:flutter/foundation.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rumah_makan/data/model/restaurant.dart';
import 'package:rumah_makan/data/model/search_restaurant_response.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchRestaurant();
  }

  late List<Restaurant> _restaurant;
  // late List<Restaurant> _searchRestaurant;
  late ResultState _state;
  // late ResultState _searchState;
  String _message = '';
  // String _searchMessage = '';

  List<Restaurant> get restaurant => _restaurant;

  ResultState get state => _state;

  String get message => _message;

  // List<Restaurant> get searchRestaurant => _searchRestaurant;
  //
  // ResultState get searchState => _searchState;
  //
  // String get searchMessage => _searchMessage;

  Future<dynamic> fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final ListRestaurantResponse restaurantResponse =
          await apiService.listRestaurant();
      final List<Restaurant> restaurants = restaurantResponse.restaurants;
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  Future<dynamic> search(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final SearchRestaurantResponse restaurantResponse =
          await apiService.searchRestaurant(query);
      final List<Restaurant> restaurants = restaurantResponse.restaurants;
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
