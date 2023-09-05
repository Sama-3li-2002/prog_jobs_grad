import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/home.dart';
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
  // circular
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffafafa),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  SizeConfig.scaleWidth(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/ProgPng2.png',
                        ),
                        Positioned(
                            top: SizeConfig.scaleHeight(170),
                            left: SizeConfig.scaleWidth(130),
                            child: TextStyleWidget(
                                'Prog Jobs',
                                Color(0xff4C5175),
                                SizeConfig.scaleTextFont(20),
                                FontWeight.bold))
                      ],
                    ),
                    TextStyleWidget(
                      'LOG IN AS ...',
                      Color(0xffcbb523),
                      SizeConfig.scaleTextFont(18),
                      FontWeight.bold,
                    ),
                    TextStyleWidget(
                        'Please choose to log in as ...',
                        Color(0xffBBBDD0),
                        SizeConfig.scaleTextFont(12),
                        FontWeight.normal),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          UserTypeScreen.type = 'programmer';
                        });
                        setState(() {
                          _isLoading = true;
                        });
                        if (FirebaseAuthController.fireAuthHelper
                            .isLoggedIn()) {
                          if (await checkIfUserInUserCollection(
                              FirebaseAuthController.fireAuthHelper.userId())) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginScreen(userType: 'programmer');
                            }));
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen(userType: 'programmer');
                          }));
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          margin:
                              EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
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
                      onTap: () async {
                        setState(() {
                          UserTypeScreen.type = 'company';
                        });
                        setState(() {
                          _isLoading = true;
                        });
                        if (FirebaseAuthController.fireAuthHelper
                            .isLoggedIn()) {
                          if (await checkIfUserInCompanyCollection(
                              FirebaseAuthController.fireAuthHelper.userId())) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ComHomeScreen();
                            }));
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginScreen(userType: 'company');
                            }));
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen(userType: 'company');
                          }));
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          margin:
                              EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
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
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkIfUserInCompanyCollection(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection(FirebaseFireStoreHelper.companyCollection)
              .doc(userId)
              .get();
      return docSnapshot.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkIfUserInUserCollection(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection(FirebaseFireStoreHelper.instance.userCollection)
              .doc(userId)
              .get();
      return docSnapshot.exists;
    } catch (e) {
      return false;
    }
  }
}
