import 'package:flutter/material.dart';
import 'package:rumah_makan/data/model/Restaurant.dart';
import 'package:rumah_makan/theme/color_schema.dart';
import 'package:rumah_makan/theme/typography.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/home_page.dart';
import 'package:rumah_makan/ui/splash_page.dart';

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
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
