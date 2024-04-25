import 'package:flutter/material.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  _LanguageToggleState createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [selectedIndex == 0, selectedIndex == 1];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int index = 0; index < isSelected.length; index++)
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: isSelected[index]
                    ? Border.all(color: Colors.white54, width: 3)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                index == 0 ? 'assets/flags/uk.png' : 'assets/flags/vietnam.png',
                width: 40,
                height: 24,
              ),
            ),
          ),
      ],
    );
  }
}
