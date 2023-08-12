import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'com_home.dart';

class ComLogoScreen extends StatefulWidget {
  static const String id = "com_logo_screen";

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
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Image(
                  width: SizeConfig.scaleWidth(244),
                  height: SizeConfig.scaleHeight(190),
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/magic.jpg',
                  )),
            ),
          ),
          Positioned(
              top: SizeConfig.scaleHeight(520),
              left: SizeConfig.scaleWidth(63),
              child: RichTextWidget(
                'W',
                Color(0xffCBB523),
                SizeConfig.scaleTextFont(50),
                FontWeight.w500,
                'elcome',
                Color(0xffCBB523),
                SizeConfig.scaleTextFont(22),
                FontWeight.w600,
              )),
          Positioned(
            top: SizeConfig.scaleHeight(570),
            left: SizeConfig.scaleWidth(190),
            child: TextStyleWidget(
              'to',
              Colors.white,
              SizeConfig.scaleTextFont(25),
              FontWeight.bold,
            ),
          ),
          Positioned(
            top: SizeConfig.scaleHeight(600),
            left: SizeConfig.scaleWidth(123),
            child: TextStyleWidget(
              'Magic Company',
              Color(0xffCBB523),
              SizeConfig.scaleTextFont(22),
              FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
