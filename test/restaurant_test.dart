import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rumah_makan/data/model/restaurant.dart';

void main() {
  group('Restaurant parsing test', () {
    test('should parse a valid object', () {
      // arrange
      const stringJson = '''
          {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
          }
      ''';

      // act
      final jsonMap = jsonDecode(stringJson) as Map<String, dynamic>;
      final restaurant = Restaurant.fromMap(jsonMap);

      // assert
      expect(restaurant.id, equals('rqdv5juczeskfw1e867'));
      expect(restaurant.name, equals('Melting Pot'));
      expect(
          restaurant.description,
          equals(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...'));
      expect(restaurant.pictureId, equals('14'));
      expect(restaurant.city, equals('Medan'));
      expect(restaurant.rating, equals(4.2));
    });

    test('should throw an error if a required field is missing', () {
      // arrange
      const jsonString = '''
        {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              "pictureId": "14"
        }
      ''';

      // act
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

      // assert
      expect(() => Restaurant.fromMap(jsonMap), throwsA(isA<TypeError>()));
    });
  });
}
