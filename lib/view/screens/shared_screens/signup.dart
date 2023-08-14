import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/home.dart';
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

  TextEditingController? _emailCom;
  TextEditingController? _passwordCom;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailCom = TextEditingController();
    _passwordCom = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailCom?.dispose();
    _passwordCom?.dispose();
  }
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
                    SizedBox(
                      width: SizeConfig.scaleWidth(321),
                      height: SizeConfig.scaleHeight(48),
                      child: ElevatedButton(
                        child: TextStyleWidget('OK', Colors.white,
                            SizeConfig.scaleTextFont(22), FontWeight.bold),
                        onPressed: () {

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
                        child: TextFieldWidget.textfieldCon(
                          controller: _emailCom,
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
                    SizedBox(
                      width: SizeConfig.scaleWidth(321),
                      height: SizeConfig.scaleHeight(48),
                      child: ElevatedButton(
                        child: TextStyleWidget('OK', Colors.white,
                            SizeConfig.scaleTextFont(22), FontWeight.bold),
                        onPressed: () async{
                          await performLogin();
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

              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future performLogin()async{
    if(checkData()){
      await signUp();
    }
  }

  bool checkData(){
    if(_emailCom!.text.isNotEmpty && _passwordCom!.text.isNotEmpty){
      return true;
    }
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

  Future signUp() async{
     UserCredential? userCredential = await FirebaseAuthController.fireStoreHelper.createAccount(_emailCom!.text, _passwordCom!.text);
       if(userCredential != null){
         Navigator.of(context)
             .push(MaterialPageRoute(builder: (context) {
           return LoginScreen(
             userType: widget.userType,
           );
         }));
     }
  }

}
