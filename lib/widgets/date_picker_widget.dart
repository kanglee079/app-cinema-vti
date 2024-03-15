import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  const DatePickerWidget({
    super.key,
    required this.onDateChanged,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(width: 15),
              const Icon(Icons.date_range, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
