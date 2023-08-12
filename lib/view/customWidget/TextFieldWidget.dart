import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class TextFieldWidget extends StatelessWidget {
  final String controller;
  final TextInputType inputType;

  TextFieldWidget({this.controller = "", this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.scaleHeight(48),
      child: TextField(
        keyboardType: inputType,
        // controller: ,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
