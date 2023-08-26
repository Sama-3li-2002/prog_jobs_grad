import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'login.dart';

class UserTypeScreen extends StatefulWidget {
  static const String id = "user_type_screen";
  static String? type;

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffafafa),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              SizeConfig.scaleWidth(29),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.scaleHeight(77)),
                ),
                TextStyleWidget(
                  'LOG IN AS ...',
                  Color(0xffcbb523),
                  SizeConfig.scaleTextFont(22),
                  FontWeight.bold,
                ),
                TextStyleWidget(
                    'Please choose to log in as ...',
                    Color(0xffBBBDD0),
                    SizeConfig.scaleTextFont(12),
                    FontWeight.normal),
                InkWell(
                  onTap: () {
                    setState(() {
                      UserTypeScreen.type = 'programmer';
                    });

                    // if(FirebaseAuthController.fireAuthHelper.isLoggedIn()){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen(userType: 'programmer');
                    }));

                    // }else{
                    //   Navigator.of(context)
                    //       .push(MaterialPageRoute(builder: (context) {
                    //     return LoginScreen(userType: 'programmer');
                    //   }));
                    //
                    // }
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/programmer.jpg',
                            height: SizeConfig.scaleHeight(151),
                            width: SizeConfig.scaleWidth(319),
                            fit: BoxFit.fill,
                            color: Colors.black.withOpacity(0.5),
                            colorBlendMode: BlendMode.darken,
                          ),
                          TextStyleWidget(
                            'Programmer',
                            Colors.white,
                            SizeConfig.scaleTextFont(20),
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      UserTypeScreen.type = 'company';
                    });
                    // if(FirebaseAuthController.fireAuthHelper.isLoggedIn()){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen(userType: 'company');
                    }));

                    // }else{
                    //   Navigator.of(context)
                    //       .push(MaterialPageRoute(builder: (context) {
                    //     return LoginScreen(userType: 'programmer');
                    //   }));
                    //
                    // }
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/company.jpg',
                            height: SizeConfig.scaleHeight(151),
                            width: SizeConfig.scaleWidth(319),
                            fit: BoxFit.fill,
                            color: Colors.black.withOpacity(0.5),
                            colorBlendMode: BlendMode.darken,
                          ),
                          TextStyleWidget(
                            'Company',
                            Colors.white,
                            SizeConfig.scaleTextFont(20),
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen(
                        userType: '',
                      );
                    }));
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.scaleHeight(10)),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/admin.jpg',
                            height: SizeConfig.scaleHeight(151),
                            width: SizeConfig.scaleWidth(319),
                            fit: BoxFit.fill,
                            color: Colors.black.withOpacity(0.5),
                            colorBlendMode: BlendMode.darken,
                          ),
                          TextStyleWidget(
                            'Admin',
                            Colors.white,
                            SizeConfig.scaleTextFont(20),
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
