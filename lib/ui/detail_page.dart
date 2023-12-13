import 'package:flutter/material.dart';
import 'package:rumah_makan/data/model/Restaurant.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail_page';

  const DetailPage({required this.restaurant, super.key});

  final Restaurant restaurant;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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

  @override
  Widget build(BuildContext context) {
    final List<String> drinks = (widget.restaurant.menus?.drinks == null)
        ? []
        : widget.restaurant.menus?.drinks
            ?.map((e) => e.name.toString())
            .toList() as List<String>;
    final List<String> foods = (widget.restaurant.menus?.foods == null)
        ? []
        : widget.restaurant.menus?.foods?.map((e) => e.name.toString()).toList()
            as List<String>;

    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraint) {
                var top = constraint.biggest.height;
                return FlexibleSpaceBar(
                  background: Image.network(
                    widget.restaurant.pictureId.toString(),
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    top > 80 && top < 90
                        ? "Detail"
                        : widget.restaurant.name.toString(),
                    overflow: TextOverflow.ellipsis,
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
                          widget.restaurant.name.toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          widget.restaurant.city.toString(),
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
                          ((widget.restaurant.rating != null)
                                  ? widget.restaurant.rating
                                  : 0.0)
                              .toString(),
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
                  widget.restaurant.description.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                buildListMenu(context, 'Drinks', drinks),
                buildListMenu(context, 'Foods', foods),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
