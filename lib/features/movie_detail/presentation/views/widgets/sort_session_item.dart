import 'package:flutter/material.dart';

class SortSessionItem extends StatefulWidget {
  const SortSessionItem({
    super.key,
  });

  @override
  State<SortSessionItem> createState() => _SortSessionItemState();
}

class _SortSessionItemState extends State<SortSessionItem> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.sort,
          color: Colors.white,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "Time",
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}
