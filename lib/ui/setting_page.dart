import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/provider/scheduling_provider.dart';
import 'package:rumah_makan/ui/widget/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/navigation.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = 'setting';

  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static const String isSubsKey = 'isSubs';
  bool isSubs = false;

  @override
  void initState() {
    super.initState();
    _loadSubsValue();
  }

  void _loadSubsValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSubs = prefs.getBool(isSubsKey) ?? false;
    });
    if (kDebugMode) {
      print('isSubs: $isSubs');
    }
  }

  void _updateSubsValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isSubsKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: GestureDetector(
          onTap: () {
            Navigation.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(child: Consumer<SchedulingProvider>(
        builder:
            (BuildContext context, SchedulingProvider provider, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Receive news letter about restaurant'),
                ),
                Switch.adaptive(
                  value: isSubs,
                  onChanged: (value) {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      provider.scheduledRestaurantSubs(value);
                      _updateSubsValue(value);
                    }
                    setState(() {
                      isSubs = value;
                    });
                  },
                  activeTrackColor:
                      Theme.of(context).colorScheme.surfaceVariant,
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
