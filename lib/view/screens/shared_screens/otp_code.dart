import 'package:flutter/material.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/RichTextWidget.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class OTPCodeScreen extends StatefulWidget {
  static const String id = "otp_code_screen";

  @override
  State<OTPCodeScreen> createState() => _OTPCodeScreenState();
}

class _OTPCodeScreenState extends State<OTPCodeScreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String? _otp;

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
            Center(
                child: Image(
                    width: SizeConfig.scaleWidth(390),
                    height: SizeConfig.scaleHeight(279),
                    image: AssetImage('assets/images/otp.png'))),
            TextStyleWidget('Enter Your OTP', Color(0xffcbb523),
                SizeConfig.scaleTextFont(22), FontWeight.bold),
            TextStyleWidget(
                'To recover the password,Please '
                'enter the code sent to your '
                'phone number',
                Color(0xffBBBDD0),
                SizeConfig.scaleTextFont(12),
                FontWeight.normal),
            SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_fieldOne, true), // auto focus
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(321),
              height: SizeConfig.scaleHeight(48),
              child: ElevatedButton(
                child: TextStyleWidget('Verify Code', Colors.white,
                    SizeConfig.scaleTextFont(22), FontWeight.bold),
                onPressed: () {
                  setState(() {
                    _otp = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;
                    showBottomSheet(context);
                  });
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

// Future<void> _sendPasswordResetEmail(String email) async {
//   try {
//     await FirebaseAuthController.fireStoreHelper.ForgetPassword(email);
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Password Reset Email Sent'),
//           content: Text('A password reset email has been sent to $email.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   } catch (error) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Please Enter Correct Email'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         });
//   }
// }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: SizeConfig.scaleHeight(20),
              bottom: SizeConfig.scaleHeight(20),
              start: SizeConfig.scaleWidth(20),
              end: SizeConfig.scaleWidth(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  margin: EdgeInsetsDirectional.only(
                    top: SizeConfig.scaleHeight(20),
                    start: SizeConfig.scaleWidth(150),
                    end: SizeConfig.scaleWidth(150),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffCBB523),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextStyleWidget("Change Password", Color(0xffCBB523),
                    SizeConfig.scaleTextFont(22), FontWeight.w500),
                SizedBox(
                  height: 10,
                ),
                TextStyleWidget("New Password: ", Color(0xff4C5175),
                    SizeConfig.scaleTextFont(15), FontWeight.w500),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.grey.shade100,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 300,
                    // margin: EdgeInsetsDirectional.only(start:SizeConfig.scaleWidth(250)),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff4C5175),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: TextStyleWidget("Save ", Colors.white,
                            SizeConfig.scaleTextFont(20), FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(
    this.controller,
    this.autoFocus,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
