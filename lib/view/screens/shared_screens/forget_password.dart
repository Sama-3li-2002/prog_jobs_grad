import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'otp_code.dart';

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
                  _sendPasswordReset();
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

  void _sendPasswordReset() async {
    String input = _inputController!.text.trim();

    if (input.isNotEmpty) {
      if (input.contains('@')) {
        await _sendPasswordResetEmail(input);
      } else {
        await _sendPasswordResetCode(input);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter an email '
                'or phone number.'),
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
    }
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

  Future<void> _sendPasswordResetCode(String phone) async {
    try {
      if (phone.isNotEmpty) {
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: (authCredential) async {
              print('Success');
            },
            verificationFailed: (authException) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('An error occurred. Please try again later.'),
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
            },
            codeSent: (verificationId, resendingToken) async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPCodeScreen(),
                ),
              );
            },
            codeAutoRetrievalTimeout: (verificationId) {},
          );
        } catch (error) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred. Please try again later.'),
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
        }
      }
    } catch (error) {
      AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    }
  }
}
