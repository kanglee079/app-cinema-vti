import 'package:flutter/material.dart';

class ItemTileAboutPage extends StatelessWidget {
  String title;
  String content;
  ItemTileAboutPage({
    super.key,
    required this.title,
    required this.content,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  })  : _textTheme = textTheme,
        _colorScheme = colorScheme;

  final TextTheme _textTheme;
  final ColorScheme _colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: _textTheme.bodyMedium?.copyWith(
                color: _colorScheme.primaryContainer,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              content,
              style: _textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
