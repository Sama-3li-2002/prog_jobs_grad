import 'package:flutter/material.dart';

class TextStyleWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  TextStyleWidget(this.text, this.color, this.fontSize, this.fontWeight);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Poppins',
          color: color,
          fontWeight: fontWeight),
    );
  }
}
