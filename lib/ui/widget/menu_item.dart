import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
