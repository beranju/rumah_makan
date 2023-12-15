import 'package:rumah_makan/data/model/restaurant.dart';

class ListRestaurantResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  ListRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory ListRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return ListRestaurantResponse(
      error: map['error'] as bool,
      founded: map['founded'] as int,
      restaurants: List<Restaurant>.from(
          map['restaurants'].map((x) => Restaurant.fromMap(x))),
    );
  }
}
