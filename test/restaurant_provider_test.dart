// mock api service
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rumah_makan/provider/restaurant_provider.dart';

class MockApiService extends Mock implements ApiService {
  MockApiService() {
    throwOnMissingStub(this);
  }

  @override
  Future<ListRestaurantResponse> listRestaurant() => (super.noSuchMethod(
        Invocation.method(#listRestaurant, []),
        returnValue: Future<ListRestaurantResponse>.value(
            ListRestaurantResponse(
                error: false, message: 'success', count: 20, restaurants: [])),
      ) as Future<ListRestaurantResponse>);

  @override
  Future<DetailRestaurantResponse> detailRestaurant(String id) =>
      (super.noSuchMethod(Invocation.method(#detailRestaurant, []),
              returnValue: Future<DetailRestaurantResponse>.value(
                  DetailRestaurantResponse(
                      error: false,
                      message: 'success',
                      restaurant: DetailRestaurant(
                          id: '',
                          name: '',
                          description: '',
                          city: '',
                          address: '',
                          pictureId: '',
                          categories: [],
                          menus: Menus(foods: [], drinks: []),
                          rating: 4.6,
                          customerReviews: []))))
          as Future<DetailRestaurantResponse>);
}

@GenerateMocks([ApiService])
void main() {
  late MockApiService apiService;
  late RestaurantProvider provider;

  setUp(() {
    apiService = MockApiService();
    provider = RestaurantProvider(apiService: apiService);
  });

  const stringJson = '''
        {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": [
              {
                  "id": "rqdv5juczeskfw1e867",
                  "name": "Melting Pot",
                  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                  "pictureId": "14",
                  "city": "Medan",
                  "rating": 4.2
              },
              {
                  "id": "s1knt6za9kkfw1e867",
                  "name": "Kafe Kita",
                  "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                  "pictureId": "25",
                  "city": "Gorontalo",
                  "rating": 4
              }
          ]
        }
      ''';
  final mapJson = jsonDecode(stringJson) as Map<String, dynamic>;
  final ListRestaurantResponse response =
      ListRestaurantResponse.fromMap(mapJson);

  group('provider test', () {
    test('should return hasData state when data is fetched successfully',
        () async {
      when(apiService.listRestaurant()).thenAnswer((_) async => response);

      await provider.fetchRestaurant();

      expect(provider.state, equals(ResultState.hasData));
      expect(provider.restaurant, equals(response.restaurants));
      verify(apiService.listRestaurant());
    });

    test('should return error state when data was fail to fetch', () async {
      when(apiService.listRestaurant()).thenThrow(Error());

      await provider.fetchRestaurant();

      expect(provider.state, equals(ResultState.error));
      verify(apiService.listRestaurant());
    });
  });
}
