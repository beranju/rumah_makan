import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/provider/db_provider.dart';
import 'package:rumah_makan/ui/widget/restaurant_item.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = 'favorite';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<DbProvider>(
        builder: (BuildContext context, DbProvider value, Widget? child) {
          final restaurants = value.restaurant;
          return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (_, index) {
                final item = restaurants[index];
                return Dismissible(
                  key: Key(item.id),
                  background: Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                  onDismissed: (direction) {
                    value.deleteRestaurant(item.id);
                  },
                  child: RestaurantItem(
                    restaurant: item,
                    onTap: () {},
                  ),
                );
              });
        },
      )),
    );
  }
}
