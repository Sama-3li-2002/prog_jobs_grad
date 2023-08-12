import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'login.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = "forget_password_screen";
  final String userType;

  ForgetPasswordScreen({required this.userType});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(29)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(10),
            ),
            Center(
                child: Image(
                    width: SizeConfig.scaleWidth(390),
                    height: SizeConfig.scaleHeight(279),
                    image: AssetImage('assets/images/forgot_password.png'))),
            TextStyleWidget('FORGET PASSWORD', Color(0xffcbb523),
                SizeConfig.scaleTextFont(22), FontWeight.bold),
            TextStyleWidget(
                'Please, enter the required data',
                Color(0xffBBBDD0),
                SizeConfig.scaleTextFont(12),
                FontWeight.normal),
            SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),
            RichTextWidget(
              'email ',
              Color(0xff4C5175),
              SizeConfig.scaleTextFont(12),
              FontWeight.w500,
              'or',
              Color(0xFFB8852F),
              SizeConfig.scaleTextFont(12),
              FontWeight.w500,
              ' phone',
              Color(0xff4C5175),
              SizeConfig.scaleTextFont(12),
              FontWeight.w500,
            ),
            SizedBox(
                width: SizeConfig.scaleWidth(321),
                height: SizeConfig.scaleHeight(48),
                child: TextFieldWidget(
                  inputType: TextInputType.text,
                )),
            SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(321),
              height: SizeConfig.scaleHeight(48),
              child: ElevatedButton(
                child: TextStyleWidget('SEND', Colors.white,
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
          ],
        ),
      ),
    );
  }
}
