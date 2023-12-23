import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/provider/restaurant_provider.dart';
import 'package:rumah_makan/ui/home_page.dart';

Widget createHomePage() => ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

void main(){
  group('HomePage Widget Test', () {
    testWidgets('Testing if listview show up', (widgetTester) async {
      await widgetTester.pumpWidget(createHomePage());
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
