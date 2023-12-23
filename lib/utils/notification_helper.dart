import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rumah_makan/data/model/list_restaurant_response.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';
import '../data/model/restaurant.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_logo');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurantResponse restaurantResponse) async {
    var channelId = "1";
    var channelName = "rumah_makan";
    var channelDescription = "Rumah makan channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    final restaurants = restaurantResponse.restaurants;
    final randomIndex = Random().nextInt(restaurants.length);
    final randomRestaurant = restaurants[randomIndex];

    var titleNotification =
        "<b>Explore ${randomRestaurant.name} restaurant</b>";
    var restaurantDetail =
        "${randomRestaurant.rating} star restaurant at ${randomRestaurant.city}";

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, restaurantDetail, platformChannelSpecifics,
        payload: json.encode(randomRestaurant.toMap()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromMap(json.decode(payload));
        Navigation.intentWithData(route, data.id);
      },
    );
  }
}
