import 'package:flutter/material.dart';

class ColoredButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final int width;
  final int height;
  final Color color;
  final String text;
  Color textColor;
  ColoredButtonWidget({
    super.key,

    required this.onPressed,
    required this.width,
    required this.height,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
      ), //allows to have multiple color during hover,focus ,etc
      onPressed: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
