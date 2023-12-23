import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/common/navigation.dart';
import 'package:rumah_makan/provider/add_review_provider.dart';
import 'package:rumah_makan/provider/db_provider.dart';
import 'package:rumah_makan/provider/detail_restaurant_provider.dart';
import 'package:rumah_makan/provider/scheduling_provider.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/favorite_page.dart';
import 'package:rumah_makan/ui/home_page.dart';
import 'package:rumah_makan/ui/setting_page.dart';
import 'package:rumah_makan/ui/splash_page.dart';
import 'package:rumah_makan/utils/background_service.dart';
import 'package:rumah_makan/utils/notification_helper.dart';

import 'common/theme/color_schema.dart';
import 'common/theme/typography.dart';
import 'data/api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
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
      navigatorKey: navigatorKey,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) =>
                      DetailRestaurantProvider(apiService: ApiService()),
                ),
                ChangeNotifierProvider(
                  create: (context) =>
                      AddReviewProvider(apiService: ApiService()),
                ),
                ChangeNotifierProvider(create: (context) => DbProvider())
              ],
              child: DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
            ),
        FavoritePage.routeName: (context) => ChangeNotifierProvider(
              create: (context) => DbProvider(),
              child: const FavoritePage(),
            ),
        SettingPage.routeName: (context) => ChangeNotifierProvider(
            create: (context) => SchedulingProvider(),
            child: const SettingPage()),
      },
    );
  }
}
