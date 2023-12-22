import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/provider/db_provider.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/widget/error.dart';
import 'package:rumah_makan/ui/widget/restaurant_item.dart';

import '../common/theme/assets_manager.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = 'favorite';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Favorite Restaurant'),
      ),
      body: SafeArea(child: Consumer<DbProvider>(
        builder: (BuildContext context, DbProvider value, Widget? child) {
          final restaurants = value.restaurant;
          if (restaurants.isEmpty) {
            return const Center(
              child: ErrorView(
                  title: 'Favorite restaurant are empty',
                  thumbnail: RawAsset.empty),
            );
          } else {
            return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (_, index) {
                  final item = restaurants[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                    onDismissed: (direction) {
                      value.deleteRestaurant(item.id);
                    },
                    child: RestaurantItem(
                      restaurant: item,
                      onTap: () {
                        Navigator.pushNamed(context, DetailPage.routeName, arguments: item.id);
                      },
                    ),
                  );
                });
          }
        },
      )),
    );
  }
}
