import 'package:flutter/material.dart';
import 'package:rumah_makan/data/model/Restaurant.dart';
import 'package:rumah_makan/theme/assets_manager.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/widget/restaurant_item.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text("Rumah Makan")),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              width: double.infinity,
              height: 50.0,
              child: Row(
                children: [
                  const Flexible(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Find restaurant'),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString(DataSource.dataSource),
                  builder: (context, snapshot) {
                    final List<Restaurant> restaurants =
                        restaurantFromJson(snapshot.data);
                    return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return RestaurantItem(restaurant: restaurant, onTap: (){
                            Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
                          },);
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
