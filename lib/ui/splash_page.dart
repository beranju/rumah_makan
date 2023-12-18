import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rumah_makan/ui/home_page.dart';

import '../common/theme/assets_manager.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash_page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<Timer> _navigateToHome() async {
    const second = 3;
    const duration = Duration(seconds: second);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.splashLogo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
