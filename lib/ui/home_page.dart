import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rumah_makan/data/model/restaurant.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/widget/restaurant_item.dart';

import '../common/theme/assets_manager.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> listRestaurant = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? error;
  bool dataNotFound = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.unfocus();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      String json = await rootBundle.loadString(DataSource.dataSource);
      List<Restaurant> restaurants = restaurantFromJson(json);
      setState(
        () {
          dataNotFound = (restaurants.isEmpty) ? true : false;
          listRestaurant = restaurants;
        },
      );
    } catch (e) {
      setState(() {
        error = 'Failed to load the data, try again';
      });
    }
  }

  void _findByName(String name) {
    List<Restaurant> filteredRestaurant = listRestaurant
        .where((restaurant) => (restaurant.name != null)
            ? restaurant.name!.toLowerCase().contains(name)
            : false)
        .toList();
    setState(
      () {
        dataNotFound = (filteredRestaurant.isEmpty) ? true : false;
        listRestaurant = filteredRestaurant;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text("Rumah Makan")),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              width: double.infinity,
              height: 75.0,
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      onTapOutside: (event) {
                        _focusNode.unfocus();
                      },
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _findByName(value);
                          _focusNode.unfocus();
                        } else {
                          _loadData();
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        suffixIcon: _controller.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    dataNotFound = false;
                                  });
                                  _controller.clear();
                                  _loadData();
                                },
                                child: const Icon(Icons.close))
                            : null,
                        hintText: 'Find restaurant',
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _findByName(_controller.text);
                          _focusNode.unfocus();
                        }
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: (error == null)
                  ? (dataNotFound)
                      ? const Center(child: Text('Restaurant not found :)'))
                      : ListView.builder(
                          itemCount: listRestaurant.length,
                          itemBuilder: (context, index) {
                            final restaurant = listRestaurant[index];
                            return RestaurantItem(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailPage.routeName,
                                    arguments: restaurant);
                              },
                            );
                          },
                        )
                  : Center(
                      child: Text(
                        error!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
