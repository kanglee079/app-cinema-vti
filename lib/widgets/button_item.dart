import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.backgroundColor = Colors.white,
    this.textStyle,
    this.textButton = 'TẠO TÀI KHOẢN',
    required this.onTap,
  });
  final Color backgroundColor;
  final TextStyle? textStyle;
  final String textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                textButton,
                style: textStyle ?? const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
