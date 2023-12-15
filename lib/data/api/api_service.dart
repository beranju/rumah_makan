import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rumah_makan/common/constants.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rumah_makan/data/model/search_restaurant_response.dart';

class ApiService {
  Future<ListRestaurantResponse> listRestaurant() async {
    const endpoint = '/list';
    final response = await http.get(Uri.parse(Constants.baseUrl + endpoint));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return ListRestaurantResponse.fromMap(body);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<DetailRestaurantResponse> detailRestaurant(String id) async {
    final endpoint = '/detail/$id';
    final response = await http.get(Uri.parse(Constants.baseUrl + endpoint));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return DetailRestaurantResponse.fromMap(body);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final endpoint = '/search?q=$query';
    final response = await http.get(Uri.parse(Constants.baseUrl + endpoint));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return SearchRestaurantResponse.fromMap(body);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }
}
