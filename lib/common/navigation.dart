import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intentReplace(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}
