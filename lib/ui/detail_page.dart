import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/common/constants.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/provider/restaurant_provider.dart';

import '../common/result_state.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = '/detail_page';

  const DetailPage({required this.id, super.key});

  final String id;

  Widget buildListMenu(BuildContext context, String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 30.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final dynamic item = items[index];
                  return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodySmall,
                      ));
                }),
          )
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, DetailRestaurant restaurant) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraint) {
                  var top = constraint.biggest.height;
                  return FlexibleSpaceBar(
                    background: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        Constants.imgBaseUrl+restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      top > 80 && top < 90 ? "Detail" : restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                    ),
                    titlePadding: const EdgeInsets.only(left: 50, bottom: 16),
                  );
                },
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    width: double.infinity,
                    child: Text(
                      'Menus',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  buildListMenu(context, 'Drinks',
                      restaurant.menus.drinks.map((e) => e.name).toList()),
                  buildListMenu(context, 'Foods',
                      restaurant.menus.foods.map((e) => e.name).toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false).detail(id);
    return Consumer<RestaurantProvider>(
      builder: (context, state, v) {
        if (state.detailState == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.detailState == ResultState.hasData) {
          final rest = state.detailRestaurant;
          return _buildDetail(context, state.detailRestaurant);
        } else if (state.detailState == ResultState.noData) {
          return Center(
            child: Text(state.detailMessage),
          );
        } else if (state.detailState == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.detailMessage),
            ),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
