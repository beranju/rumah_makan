import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/provider/detail_restaurant_provider.dart';

import 'restaurant_provider_test.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService apiService;
  late DetailRestaurantProvider provider;

  setUp(() {
    apiService = MockApiService();
    provider = DetailRestaurantProvider(apiService: apiService);
  });

  const stringJson = '''
    {
      "error": false,
      "message": "success",
      "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
              {
                  "name": "Italia"
              },
              {
                  "name": "Modern"
              }
          ],
          "menus": {
              "foods": [
                  {
                      "name": "Paket rosemary"
                  },
                  {
                      "name": "Toastie salmon"
                  }
              ],
              "drinks": [
                  {
                      "name": "Es krim"
                  },
                  {
                      "name": "Sirup"
                  }
              ]
          },
          "rating": 4.2,
          "customerReviews": [
              {
                  "name": "Ahmad",
                  "review": "Tidak rekomendasi untuk pelajar!",
                  "date": "13 November 2019"
              }
          ]
      }
    }
  ''';
  final mapJson = jsonDecode(stringJson) as Map<String, dynamic>;
  final response = DetailRestaurantResponse.fromMap(mapJson);

  group('Detail Restaurant provider', () {
    test('should return has data state when is fetch successfully', () async {
      when(apiService.detailRestaurant('rqdv5juczeskfw1e867'))
          .thenAnswer((_) async => response);

      await provider.detail('rqdv5juczeskfw1e867');

      expect(provider.detailState, equals(ResultState.hasData));
      expect(provider.detailRestaurant, equals(response.restaurant));
      verify(apiService.detailRestaurant('rqdv5juczeskfw1e867'));
    });

    test('should return error state when data was fail to fetch', () async {
      when(apiService.listRestaurant()).thenThrow(Error());

      await provider.detail('');

      expect(provider.detailState, equals(ResultState.error));
      verify(apiService.detailRestaurant(''));
    });
  });
}
