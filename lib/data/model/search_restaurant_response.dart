import 'package:rumah_makan/data/model/restaurant.dart';

class SearchRestaurantResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return SearchRestaurantResponse(
      error: map['error'] as bool,
      founded: map['founded'] as int,
      restaurants: List<Restaurant>.from(
          map['restaurants'].map((x) => Restaurant.fromMap(x))),
    );
  }
}
