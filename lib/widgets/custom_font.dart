import 'package:flutter/material.dart';

class CustomFont extends StatelessWidget {
  const CustomFont(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.left,
      this.letterSpacing = 0,
      this.fontStyle = FontStyle.normal});

  final String text;
  final double fontSize, letterSpacing;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          fontStyle: fontStyle),
    ); // Text
  }
}
