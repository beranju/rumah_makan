import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/restaurant.dart';
import 'package:rumah_makan/provider/restaurant_provider.dart';
import 'package:rumah_makan/ui/detail_page.dart';
import 'package:rumah_makan/ui/widget/platform_widget.dart';
import 'package:rumah_makan/ui/widget/restaurant_item.dart';
import 'package:rumah_makan/ui/widget/shimmer_list.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isShowClose = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.unfocus();
    super.dispose();
  }

  Widget _listRestaurant(BuildContext context, List<Restaurant> restaurant) {
    return ListView.builder(
      itemCount: restaurant.length,
      itemBuilder: (context, index) {
        final rest = restaurant[index];
        return RestaurantItem(
          restaurant: rest,
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: rest.id);
          },
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, v) {
        if (state.state == ResultState.loading) {
          return const ShimmerList();
        } else if (state.state == ResultState.hasData) {
          final rest = state.restaurant;
          return _listRestaurant(context, state.restaurant);
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
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

  Widget _buildAndroid(BuildContext context) {
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
                      onChanged: (value) {
                        setState(() {
                          isShowClose = value.isNotEmpty;
                        });
                      },
                      onTapOutside: (event) {
                        _focusNode.unfocus();
                      },
                      onSubmitted: (value) {
                        Provider.of<RestaurantProvider>(context, listen: false)
                            .search(value);
                        _focusNode.unfocus();
                        setState(() {
                          isShowClose = false;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        suffixIcon: isShowClose == true
                            ? IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  // _focusNode.unfocus();
                                  // Provider.of<RestaurantProvider>(context,
                                  //         listen: false)
                                  //     .fetchRestaurant();
                                },
                                icon: const Icon(
                                  Icons.close,
                                ),
                              )
                            : null,
                        hintText: 'Find restaurant',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        final value = _controller.text;
                        Provider.of<RestaurantProvider>(context, listen: false)
                            .search(value);
                        _focusNode.unfocus();
                        setState(() {
                          isShowClose = false;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildList());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
