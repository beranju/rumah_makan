import 'package:rumah_makan/data/model/restaurant.dart';

class ListRestaurantResponse {
  bool error;
  String message;
  num count;
  List<Restaurant> restaurants;

  ListRestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return ListRestaurantResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      count: map['count'] as num,
      restaurants: List<Restaurant>.from(
          map['restaurants'].map((r) => Restaurant.fromMap(r))
      ),
    );
  }
}
