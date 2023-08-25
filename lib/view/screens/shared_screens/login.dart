import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/signup.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'forget_password.dart';
import '../ProgrammerScreen/home.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  final String userType;

  LoginScreen({required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Programmer Info
  TextEditingController? _emailProg;
  TextEditingController? _passwordProg;

  // Company Info
  TextEditingController? _emailCom;
  TextEditingController? _passwordCom;

  @override
  void initState() {
    super.initState();
    // Programmer Info
    _emailProg = TextEditingController();
    _passwordProg = TextEditingController();

    // Company Info
    _emailCom = TextEditingController();
    _passwordCom = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // Programmer Info
    _emailProg?.dispose();
    _passwordProg?.dispose();

    // Company Info
    _emailCom?.dispose();
    _passwordCom?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.scaleWidth(20),
            ),
            color: Color(0xff4C5175),
          ),
        ),
        backgroundColor: Color(0xfffafafa),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(29)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Center(
                    child: Image(
                        width: SizeConfig.scaleWidth(390),
                        height: SizeConfig.scaleHeight(259),
                        image: AssetImage('assets/images/Login_pana.png'))),
              ),
              TextStyleWidget(
                'LOGIN',
                Color(0xffcbb523),
                SizeConfig.scaleTextFont(22),
                FontWeight.bold,
              ),
              TextStyleWidget(
                'Please, enter the required data',
                Color(0xffBBBDD0),
                SizeConfig.scaleTextFont(12),
                FontWeight.normal,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              if (widget.userType == 'programmer')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget(
                      'Programmer Email',
                      Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12),
                      FontWeight.w500,
                    ),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget.textfieldCon(
                          controller: _emailProg,
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('password', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                      width: SizeConfig.scaleWidth(321),
                      height: SizeConfig.scaleHeight(48),
                      child: TextField(
                        controller: _passwordProg,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ],
                )
              else if (widget.userType == 'company')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget(
                      'Company Email',
                      Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12),
                      FontWeight.w500,
                    ),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget.textfieldCon(
                          controller: _emailCom,
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('password', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                      width: SizeConfig.scaleWidth(321),
                      height: SizeConfig.scaleHeight(48),
                      child: TextField(
                        controller: _passwordCom,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ],
                ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ForgetPasswordScreen(
                        userType: widget.userType,
                      );
                    }));
                  },
                  child: TextStyleWidget('Forget Password?', Color(0xFFB8852F),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                ),
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(321),
                height: SizeConfig.scaleHeight(48),
                child: ElevatedButton(
                  child: TextStyleWidget('LOGIN', Colors.white,
                      SizeConfig.scaleTextFont(22), FontWeight.bold),
                  onPressed: () async {
                    if (UserTypeScreen.type == 'programmer') {
                      await performLoginProg();
                    } else if (UserTypeScreen.type == 'company') {
                      await performLoginCom();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3b3f5b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextStyleWidget(
                          "Don't have an account? ",
                          Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12),
                          FontWeight.normal),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return SignupScreen(userType: widget.userType);
                          }));
                        },
                        child: TextStyleWidget("Sign up", Color(0xFFB8852F),
                            SizeConfig.scaleTextFont(12), FontWeight.normal),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // Programmer Info
  Future performLoginProg() async {
    if (_emailProg!.text.isNotEmpty && _passwordProg!.text.isNotEmpty) {
      UserCredential? userCredential =
          await FirebaseAuthController.fireAuthHelper.signIn(
        _emailProg!.text,
        _passwordProg!.text,
      );
      if (userCredential != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    } else {
      Fluttertoast.showToast(
        msg: "Email or Password can't be empty",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // Company Info
  Future performLoginCom() async {
    if (checkData()) {
      await logIn();
    }
  }

  bool checkData() {
    if (_emailCom!.text.isNotEmpty && _passwordCom!.text.isNotEmpty) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Email or Password can't be empty",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future logIn() async {
    UserCredential? userCredential = await FirebaseAuthController.fireAuthHelper
        .signIn(_emailCom!.text, _passwordCom!.text);

    if (userCredential != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ComHomeScreen();
          },
        ),
      );
    }
  }
}
