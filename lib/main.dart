import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/provider/add_review_provider.dart';
import 'package:rumah_makan/provider/detail_restaurant_provider.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/home_page.dart';
import 'package:rumah_makan/ui/splash_page.dart';

import 'common/theme/color_schema.dart';
import 'common/theme/typography.dart';
import 'data/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: myTextStyle),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: myTextStyle),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) =>
                        DetailRestaurantProvider(apiService: ApiService())),
                ChangeNotifierProvider(
                    create: (context) =>
                        AddReviewProvider(apiService: ApiService())),
              ],
              child: DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
            ),
      },
    );
  }
}
