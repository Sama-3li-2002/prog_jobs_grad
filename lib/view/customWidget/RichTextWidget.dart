import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String text1;
  final Color color1;
  final FontWeight fontWeight1;
  final double fontSize1;
  final String text2;
  final Color color2;
  final FontWeight fontWeight2;
  final double fontSize2;
  String? text3;
  Color? color3;
  FontWeight? fontWeight3;
  double? fontSize3;

  RichTextWidget(
    this.text1,
    this.color1,
    this.fontSize1,
    this.fontWeight1,
    this.text2,
    this.color2,
    this.fontSize2,
    this.fontWeight2, [
    this.text3,
    @required this.color3,
    @required this.fontSize3,
    @required this.fontWeight3,
  ]);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: this.text1,
            style: TextStyle(
                fontSize: fontSize1,
                fontFamily: 'Poppins',
                color: color1,
                fontWeight: fontWeight1),
            children: [
          TextSpan(
              text: this.text2,
              style: TextStyle(
                  fontSize: fontSize2,
                  fontFamily: 'Poppins',
                  color: color2,
                  fontWeight: fontWeight2)),
          TextSpan(
              text: this.text3,
              style: TextStyle(
                  fontSize: fontSize3,
                  fontFamily: 'Poppins',
                  color: color3,
                  fontWeight: fontWeight3)),
        ]));
  }
}
