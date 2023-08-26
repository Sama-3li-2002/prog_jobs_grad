import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'com_home.dart';

class ComLogoScreen extends StatefulWidget {
  static const String id = "com_logo_screen";
  String comName;

  ComLogoScreen({required this.comName});

  @override
  State<ComLogoScreen> createState() => _ComLogoScreenState();
}

class _ComLogoScreenState extends State<ComLogoScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then(
      (value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return ComHomeScreen();
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backg2.png',
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            fit: BoxFit.fill,
            color: Colors.black.withOpacity(0.8),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
              top: SizeConfig.scaleHeight(320),
              left: SizeConfig.scaleWidth(95),
              child: RichTextWidget(
                'W',
                Color(0xffCBB523),
                SizeConfig.scaleTextFont(60),
                FontWeight.w500,
                'elcome',
                Color(0xffCBB523),
                SizeConfig.scaleTextFont(30),
                FontWeight.w600,
              )),
          Positioned(
            top: SizeConfig.scaleHeight(380),
            left: SizeConfig.scaleWidth(220),
            child: TextStyleWidget(
              'to',
              Colors.white,
              SizeConfig.scaleTextFont(35),
              FontWeight.bold,
            ),
          ),
          Positioned(
            top: SizeConfig.scaleHeight(410),
            left: SizeConfig.scaleWidth(150),
            child: TextStyleWidget(
              widget.comName,
              Color(0xffCBB523),
              SizeConfig.scaleTextFont(35),
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
