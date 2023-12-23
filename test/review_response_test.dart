import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rumah_makan/data/model/review_response.dart';

void main() {
  group('ReviewResponse parsing test', () {
    test('Should parse valid object', () {
      const stringJson = '''
        {
          "error": false,
          "message": "success",
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {
              "name": "test",
              "review": "makanannya lezat",
              "date": "29 Oktober 2020"
            }
          ]
        }
      ''';

      final mapJson = jsonDecode(stringJson) as Map<String, dynamic>;
      final reviewResponse = ReviewResponse.fromMap(mapJson);

      expect(reviewResponse.error, equals(false));
      expect(reviewResponse.message, equals('success'));
      expect(reviewResponse.customerReviews, isNotEmpty);
    });

    test('Should throw an error if a required field is missing', () {
      const stringJson = '''
        {
          "error": false
        }
      ''';

      final mapJson = jsonDecode(stringJson) as Map<String, dynamic>;

      expect(() => ReviewResponse.fromMap(mapJson), throwsA(isA<TypeError>()));
    });
  });
}
