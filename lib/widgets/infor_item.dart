import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? child;
  final bool isDeco;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const InfoRow({
    super.key,
    required this.title,
    this.isDeco = true,
    this.value,
    this.child,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration? decoration = isDeco
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          )
        : null;

    Padding? padding = isDeco
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: child ??
                Text(
                  value ?? "Default value",
                  style: valueStyle ??
                      const TextStyle(
                        fontSize: 15,
                      ),
                ),
          )
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle ?? const TextStyle(fontSize: 15),
          ),
          const Expanded(child: SizedBox(width: 1)),
          Container(
            padding: padding?.padding,
            decoration: decoration,
            child: child ??
                Text(
                  value ?? "Default value",
                  style: valueStyle ??
                      const TextStyle(
                        fontSize: 15,
                      ),
                ),
          ),
        ],
      ),
    );
  }
}
