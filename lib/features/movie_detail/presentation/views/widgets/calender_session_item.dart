// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class CalendarSessionItem extends StatefulWidget {
  Function(DateTime) onDateChanged;
  CalendarSessionItem({
    super.key,
    required this.onDateChanged,
  });

  @override
  State<CalendarSessionItem> createState() => _CalendarSessionItemState();
}

class _CalendarSessionItemState extends State<CalendarSessionItem> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () async {
        final result = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2099),
        );
        if (result != null) {
          setState(() {
            selectedDate = result;
          });
          widget.onDateChanged(result);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            formatDate(selectedDate, [M, ' ', dd]),
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
