import 'package:flutter/material.dart';
import 'package:rumah_makan/common/theme/assets_manager.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (_, i) {
          return ListTile(
            leading: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                shape: BoxShape.rectangle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.1,
                  image: AssetImage(Images.splashLogo),
                ),
              ),
            ),
            title: Container(
              width: double.infinity,
              height: 30.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 8.0),
              width: double.infinity,
              height: 15.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          );
          // return Container(
          //   width: double.infinity,
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          //   child: Row(
          //     children: [
          //       Stack(children: [
          //         Container(
          //           width: 100.0,
          //           height: 100.0,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.0),
          //             shape: BoxShape.rectangle,
          //             image: const DecorationImage(
          //               fit: BoxFit.cover,
          //               opacity: 0.1,
          //               image: NetworkImage(
          //                   'https://cdn.99images.com/photos/wallpapers/3d-abstract/abstract-forest%20android-iphone-desktop-hd-backgrounds-wallpapers-1080p-4k-swrhr.jpg'),
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           right: 0.0,
          //           top: 0.0,
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 color: Theme.of(context).colorScheme.surfaceVariant,
          //                 shape: BoxShape.rectangle,
          //                 borderRadius: const BorderRadius.only(
          //                     bottomLeft: Radius.circular(10),
          //                     topRight: Radius.circular(10.0))),
          //             padding: const EdgeInsets.all(2.0),
          //             child: const Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text(''),
          //                 Icon(
          //                   Icons.star,
          //                   color: Colors.orange,
          //                   size: 15.0,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ]),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          //             child: Text(
          //               '',
          //               style: Theme.of(context).textTheme.titleLarge,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8.0),
          //             child: Text(
          //               '',
          //               style: Theme.of(context).textTheme.bodyMedium,
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
