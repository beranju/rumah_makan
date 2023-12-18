import 'package:flutter/foundation.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/customer_review.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rumah_makan/data/model/restaurant.dart';
import 'package:rumah_makan/data/model/review_request.dart';
import 'package:rumah_makan/data/model/review_response.dart';
import 'package:rumah_makan/data/model/search_restaurant_response.dart';

import '../data/model/detail_restaurant_response.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchRestaurant();
  }

  late List<Restaurant> _restaurant;
  late DetailRestaurant _detailRestaurant;
  late List<Review> _review;
  late ResultState _state;
  late ResultState _detailState;
  String _message = '';
  String _detailMessage = '';

  List<Restaurant> get restaurant => _restaurant;

  ResultState get state => _state;

  String get message => _message;

  DetailRestaurant get detailRestaurant => _detailRestaurant;

  List<Review> get review => _review;

  ResultState get detailState => _detailState;

  String get detailMessage => _detailMessage;

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

  Future<dynamic> detail(String id) async {
    try {
      _detailState = ResultState.loading;
      notifyListeners();
      final DetailRestaurantResponse response =
          await apiService.detailRestaurant(id);
      final DetailRestaurant restaurant = response.restaurant;
      _detailState = ResultState.hasData;
      notifyListeners();
      return _detailRestaurant = restaurant;
    } catch (e) {
      _detailState = ResultState.error;
      notifyListeners();
      return _detailMessage = 'Error -> $e';
    }
  }

  Future<dynamic> addReview(ReviewRequest request) async {
    try {
      _detailState = ResultState.loading;
      notifyListeners();
      final ReviewResponse response = await apiService.addReview(request);
      if (response.customerReviews.isEmpty) {
        _detailState = ResultState.noData;
        notifyListeners();
        return _detailMessage = 'Empty data';
      } else {
        _detailState = ResultState.hasData;
        notifyListeners();
        return _review = response.customerReviews;
      }
    } catch (e) {
      _detailState = ResultState.error;
      notifyListeners();
      return _detailMessage = 'Error -> $e';
    }
  }
}
