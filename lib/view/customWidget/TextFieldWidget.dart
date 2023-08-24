import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  final TextInputType inputType;
  String? hint_Text;

  TextFieldWidget({this.inputType = TextInputType.text, this.hint_Text = ""});

  TextFieldWidget.textfieldCon(
      {this.controller,
      this.inputType = TextInputType.text,
      this.hint_Text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.scaleHeight(48),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint_Text,
            hintStyle: TextStyle(
              fontSize: SizeConfig.scaleTextFont(12),
              fontFamily: 'Poppins',
              color: Colors.grey.shade400,
            ),
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
