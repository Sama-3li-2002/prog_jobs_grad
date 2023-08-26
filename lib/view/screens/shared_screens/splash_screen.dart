import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/customWidget/textStyleWidget.dart';

import 'user_type.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then(
      (value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return UserTypeScreen();
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff3b3f5b),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/progPng.png',
            ),
            Positioned(
                top: SizeConfig.scaleHeight(200),
                left: SizeConfig.scaleWidth(130),
                child: TextStyleWidget(
                    'Prog Jobs', Colors.white, 30, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
