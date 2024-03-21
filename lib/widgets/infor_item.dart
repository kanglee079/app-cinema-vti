import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool isDeco;
  final bool isPhone;
  final TextStyle? titleStyle;
  final TextEditingController? controller;

  const InfoRow({
    super.key,
    required this.title,
    this.isDeco = true,
    this.child,
    this.isPhone = false,
    this.titleStyle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: titleStyle ??
                  const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 2,
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: isDeco
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    )
                  : null,
              child: child ??
                  TextField(
                    controller: controller,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: isPhone
                          ? const Icon(Icons.phone, color: Colors.white)
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: InputBorder.none,
                      hintText: "Enter value",
                      hintStyle: const TextStyle(color: Colors.white54),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
