import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem(
      {super.key,
      required this.name,
      required this.review,
      required this.date});

  final String name;
  final String review;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            review,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            date,
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.0),
          ),
        ),
      ]),
    );
  }
}
