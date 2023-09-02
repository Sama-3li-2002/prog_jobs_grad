import 'package:flutter/material.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = "forget_password_screen";
  final String userType;

  ForgetPasswordScreen({required this.userType});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController? _inputController = TextEditingController();

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
            TextStyleWidget(
              'Enter Your Email',
              Color(0xff4C5175),
              SizeConfig.scaleTextFont(12),
              FontWeight.w500,
            ),
            SizedBox(
                width: SizeConfig.scaleWidth(321),
                height: SizeConfig.scaleHeight(48),
                child: TextFieldWidget.textfieldCon(
                  controller: _inputController,
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
                  _sendPasswordResetEmail(_inputController!.text);
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

  Future _sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuthController.fireAuthHelper.ForgetPassword(email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text('A password reset email has been sent to $email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please Enter Correct Email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }
}
