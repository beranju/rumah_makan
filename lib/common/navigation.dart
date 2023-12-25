import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {

  static Future<void> intentWithData(String routeName, Object arguments) async {
    await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intentReplace(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}
