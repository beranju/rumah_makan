import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/common/constants.dart';
import 'package:rumah_makan/common/theme/assets_manager.dart';
import 'package:rumah_makan/data/model/detail_restaurant_response.dart';
import 'package:rumah_makan/data/model/review_request.dart';
import 'package:rumah_makan/provider/add_review_provider.dart';
import 'package:rumah_makan/provider/detail_restaurant_provider.dart';
import 'package:rumah_makan/ui/widget/error.dart';
import 'package:rumah_makan/ui/widget/menu_item.dart';
import 'package:rumah_makan/ui/widget/review_item.dart';

import '../common/result_state.dart';
import '../data/model/customer_review.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail_page';

  const DetailPage({required this.id, super.key});

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DetailRestaurantProvider>().detail(widget.id);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _addReview(BuildContext context) {
    String? message;
    AlertDialog dialog = AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      scrollable: true,
      title: const Text('Add review'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              final review = _reviewController.text;
              if (name.isNotEmpty && review.isNotEmpty) {
                final request =
                    ReviewRequest(id: widget.id, name: name, review: review);
                Provider.of<AddReviewProvider>(context, listen: false)
                    .addReview(request);
                setState(() {
                  message = null;
                });
                Navigator.of(context).pop();
              } else {
                setState(() {
                  message = 'Name and review shouldn\'t be empty';
                });
              }
            },
            child: const Text('Send')),
      ],
      content: Column(
        children: [
          Text(
            (message == null) ? '' : message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 75.0,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Input your name',
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 75.0,
            child: TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Input your review',
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          )
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (context) =>
            SizedBox(height: 200.0, width: double.infinity, child: dialog));
    return;
  }

  Widget buildListMenu(BuildContext context, String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
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
                return MenuItem(title: item);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReview(BuildContext context, List<Review> customerReviews) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      height: 250.0,
      width: double.infinity,
      child: ListView.builder(
        itemCount: customerReviews.length,
        itemBuilder: (c, index) {
          final review = customerReviews[index];
          return ReviewItem(
              name: review.name, review: review.review, date: review.date);
        },
      ),
    );
  }

  Widget _buildDetail(BuildContext context, DetailRestaurant restaurant) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: NestedScrollView(
        headerSliverBuilder: (c, isScrolled) {
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
                        Constants.imgBaseUrl + restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      top > 80 && top < 90 ? restaurant.name : '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    titlePadding: const EdgeInsets.only(left: 50, bottom: 16),
                  );
                },
              ),
            )
          ];
        },
        body: Consumer<AddReviewProvider>(
          builder: (c, state, _) {
            if (state.state == ResultState.hasData) {
              Provider.of<DetailRestaurantProvider>(c, listen: false)
                  .detail(widget.id);
            }
            return Scaffold(
              floatingActionButton: FilledButton.icon(
                icon: const Icon(Icons.reviews),
                onPressed: () => _addReview(context),
                label: const Text('Add review'),
              ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                        buildListMenu(
                            context,
                            'Drinks',
                            restaurant.menus.drinks
                                .map((e) => e.name)
                                .toList()),
                        buildListMenu(context, 'Foods',
                            restaurant.menus.foods.map((e) => e.name).toList()),
                        Container(
                          margin: const EdgeInsets.only(top: 12.0),
                          width: double.infinity,
                          child: Text(
                            'Reviews',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        _buildReview(context, restaurant.customerReviews),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Consumer<DetailRestaurantProvider>(
        builder: (context, state, v) {
          if (state.detailState == ResultState.loading) {
            return Center(
              child: Material(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Lottie.asset(RawAsset.loading))),
            );
          } else if (state.detailState == ResultState.hasData) {
            return _buildDetail(context, state.detailRestaurant);
          } else if (state.detailState == ResultState.error) {
            return Center(
              child: ErrorView(
                  title: state.detailMessage, thumbnail: RawAsset.error),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
