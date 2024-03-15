import 'package:flutter/material.dart';

enum Gender {
  Male,
  Female,
  Other,
}

class GenderItem extends StatefulWidget {
  final Function(Gender) onGenderChanged;
  const GenderItem({
    super.key,
    required this.onGenderChanged,
  });

  @override
  State<GenderItem> createState() => _GenderItemState();
}

class _GenderItemState extends State<GenderItem> {
  late Gender selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = Gender.Male;
  }

  Color _getBorderColor(Gender gender) {
    switch (gender) {
      case Gender.Male:
        return Colors.blue;
      case Gender.Female:
        return Colors.pink;
      case Gender.Other:
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  Widget _buildGenderOption(Gender gender, String text) {
    final isSelected = selectedGender == gender;
    final borderColor = _getBorderColor(gender);

    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
        widget.onGenderChanged(gender);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: isSelected ? borderColor : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: Transform.scale(
                scale: 0.8,
                child: Radio<Gender>(
                  value: gender,
                  groupValue: selectedGender,
                  onChanged: (Gender? newGender) {
                    setState(() {
                      selectedGender = newGender!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildGenderOption(Gender.Male, "Male"),
        const SizedBox(width: 2),
        _buildGenderOption(Gender.Female, "Female"),
        const SizedBox(width: 2),
        _buildGenderOption(Gender.Other, "Other"),
      ],
    );
  }
}
