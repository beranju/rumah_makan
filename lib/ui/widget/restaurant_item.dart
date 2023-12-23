import 'package:flutter/material.dart';
import 'package:rumah_makan/common/constants.dart';
import 'package:rumah_makan/data/model/restaurant.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem(
      {super.key, required this.restaurant, required this.onTap});

  final Restaurant restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Row(
          children: [
            Stack(children: [
              Hero(
                tag: restaurant.pictureId.toString(),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        Constants.imgBaseUrl + restaurant.pictureId.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10.0))),
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(restaurant.rating.toString()),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  child: Text(
                    restaurant.name.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    restaurant.city.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
