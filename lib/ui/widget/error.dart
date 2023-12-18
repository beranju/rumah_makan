import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.title, required this.thumbnail});

  final String title;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 100, height: 100, child: Lottie.asset(thumbnail)),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
