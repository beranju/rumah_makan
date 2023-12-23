import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rumah_makan/common/constants.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rumah_makan/data/model/review_request.dart';
import 'package:rumah_makan/data/model/review_response.dart';
import 'package:rumah_makan/data/model/search_restaurant_response.dart';

class ApiService {
  // Singleton class
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal();

  Future<ListRestaurantResponse> listRestaurant() async {
    const endpoint = '/list';
    return await _getDataFromAPI(
        endpoint, (fromMap) => ListRestaurantResponse.fromMap(fromMap));
  }

  Future<DetailRestaurantResponse> detailRestaurant(String id) async {
    final endpoint = '/detail/$id';
    return await _getDataFromAPI(
        endpoint, (fromMap) => DetailRestaurantResponse.fromMap(fromMap));
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final endpoint = '/search?q=$query';
    return await _getDataFromAPI(
        endpoint, (fromMap) => SearchRestaurantResponse.fromMap(fromMap));
  }

  Future<ReviewResponse> addReview(ReviewRequest body) async {
    const endpoint = '/review';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(Uri.parse(Constants.baseUrl + endpoint),
          body: jsonEncode(body.toMap()), headers: headers);
      final responseBody = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReviewResponse.fromMap(responseBody);
      } else {
        throw Exception(responseBody['message']);
      }
    } on SocketException catch (e) {
      throw Exception('Check your internet connection!');
    } on TimeoutException catch (e) {
      throw Exception('Timeout, Check your internet connection!');
    } on Error {
      throw Exception('Something went wrong');
    }
  }

  Future<T> _getDataFromAPI<T>(
      String endpoint, T Function(Map<String, dynamic> fromMap) fromMap) async {
    int timeout = 10;
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.baseUrl + endpoint))
          .timeout(Duration(seconds: timeout));
      final responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return fromMap(body);
      } else {
        throw Exception(responseBody['message']);
      }
    } on SocketException catch (e) {
      throw Exception('Check your internet connection!');
    } on TimeoutException catch (e) {
      throw Exception('Connection timeout, try again!');
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('Something went wrong');
    }
  }
}
