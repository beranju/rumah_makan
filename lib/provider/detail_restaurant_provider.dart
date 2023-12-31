import 'package:flutter/foundation.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';

import '../data/model/detail_restaurant_response.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  late DetailRestaurant _detailRestaurant;
  late ResultState _detailState;
  String _detailMessage = '';

  DetailRestaurant get detailRestaurant => _detailRestaurant;

  ResultState get detailState => _detailState;

  String get detailMessage => _detailMessage;

  Future<void> detail(String id) async {
    try {
      _detailState = ResultState.loading;
      // notifyListeners();
      final DetailRestaurantResponse response =
          await apiService.detailRestaurant(id);
      final DetailRestaurant restaurant = response.restaurant;
      if(response.error){
        _detailState = ResultState.error;
        notifyListeners();
        _detailMessage = response.message;
      }else{
        _detailState = ResultState.hasData;
        notifyListeners();
        _detailRestaurant = restaurant;
      }
    } catch (e) {
      _detailState = ResultState.error;
      _detailMessage = e.toString();
    }
  }
}
