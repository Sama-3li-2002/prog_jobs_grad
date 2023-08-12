import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import '../shared_screens/login.dart';

class SignupScreen extends StatefulWidget {
  static const String id = "signup_screen";

  final String userType;

  SignupScreen({required this.userType});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(14),
          ),
          color: Color(0xff4C5175),
        ),
      ),
      backgroundColor: Color(0xfffafafa),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(29)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                      width: SizeConfig.scaleWidth(390),
                      height: SizeConfig.scaleHeight(218),
                      image: AssetImage('assets/images/signup.png'))),
              TextStyleWidget('SIGN UP', Color(0xffcbb523),
                  SizeConfig.scaleTextFont(22), FontWeight.bold),
              TextStyleWidget(
                  'Please, enter the required data',
                  Color(0xffBBBDD0),
                  SizeConfig.scaleTextFont(12),
                  FontWeight.normal),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              if (widget.userType == 'programmer')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget('username', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('E_mail', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.emailAddress,
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
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('age', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.number,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('phone', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.phone,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('specialization', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('about', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.multiline,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                  ],
                )
              else if (widget.userType == 'company')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget('Company Name:', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('E_mail', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.emailAddress,
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
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('phone', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.phone,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('Address', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('Social media accounts:', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.text,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                    TextStyleWidget('about', Color(0xff4C5175),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                    SizedBox(
                        width: SizeConfig.scaleWidth(321),
                        height: SizeConfig.scaleHeight(48),
                        child: TextFieldWidget(
                          inputType: TextInputType.multiline,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(20),
                    ),
                  ],
                ),
              SizedBox(
                width: SizeConfig.scaleWidth(321),
                height: SizeConfig.scaleHeight(48),
                child: ElevatedButton(
                  child: TextStyleWidget('OK', Colors.white,
                      SizeConfig.scaleTextFont(22), FontWeight.bold),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen(
                        userType: widget.userType,
                      );
                    }));
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
                height: SizeConfig.scaleHeight(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
