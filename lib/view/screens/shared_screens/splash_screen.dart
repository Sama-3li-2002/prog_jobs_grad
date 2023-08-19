import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AddNewJobScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/all_jobs.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/home.dart';

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
        child: Image(
          width: SizeConfig.scaleWidth(205),
          height: SizeConfig.scaleHeight(163),
          image: AssetImage('assets/images/LOGO.png'),
        ),
      ),
    );
  }
}
