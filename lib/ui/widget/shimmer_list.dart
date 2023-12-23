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
        },
      ),
    );
  }
}
