import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';
import '../../../model/CompanyModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import '../CompanyScreens/com_logo.dart';
import '../shared_screens/login.dart';

class SignupScreen extends StatefulWidget {
  static const String id = "signup_screen";

  final String userType;

  SignupScreen({required this.userType});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Programmer Info
  TextEditingController? _usernameProg;
  TextEditingController? _emailProg;
  TextEditingController? _passwordProg;
  TextEditingController? _phoneProg;
  TextEditingController? _ageProg;
  TextEditingController? _specializationProg;
  TextEditingController? _aboutProg;
  TextEditingController? _confirmPasswordProg;

  // Company Info
  TextEditingController? _emailCom;
  TextEditingController? _passwordCom;
  TextEditingController? _companyNameCom;
  TextEditingController? _phoneCom;
  TextEditingController? _addressCom;
  TextEditingController? _aboutCom;
  TextEditingController? _managerCom;
  TextEditingController? _confirmPasswordCom;

  // visible pass
  bool _obscureText = true;

  // circular
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Programmer Info
    _usernameProg = TextEditingController();
    _emailProg = TextEditingController();
    _passwordProg = TextEditingController();
    _phoneProg = TextEditingController();
    _ageProg = TextEditingController();
    _specializationProg = TextEditingController();
    _aboutProg = TextEditingController();
    _confirmPasswordProg = TextEditingController();

    // Company Info
    _emailCom = TextEditingController();
    _passwordCom = TextEditingController();
    _companyNameCom = TextEditingController();
    _phoneCom = TextEditingController();
    _addressCom = TextEditingController();
    _aboutCom = TextEditingController();
    _managerCom = TextEditingController();
    _confirmPasswordCom = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // Programmer Info
    _usernameProg?.dispose();
    _emailProg?.dispose();
    _passwordProg?.dispose();
    _phoneProg?.dispose();
    _ageProg?.dispose();
    _specializationProg?.dispose();
    _aboutProg?.dispose();
    _confirmPasswordProg?.dispose();

    // Company Info
    _emailCom?.dispose();
    _passwordCom?.dispose();
    _companyNameCom?.dispose();
    _phoneCom?.dispose();
    _addressCom?.dispose();
    _aboutCom?.dispose();
    _confirmPasswordCom?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(29)),
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _usernameProg,
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
                              inputType: TextInputType.emailAddress,
                              controller: _emailProg,
                            )),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('password', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(86),
                          child: TextField(
                            controller: _passwordProg,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              helperText:
                                  'Password must contain letters(capital & small), numbers '
                                  '\nspecial characters and not less than 8',
                              helperStyle: TextStyle(
                                fontSize: SizeConfig.scaleTextFont(12),
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText
                                      ? Color(0xffcbb523)
                                      : Color(0xffcbb523),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('confirm password', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(48),
                          child: TextField(
                            controller: _confirmPasswordProg,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText
                                      ? Color(0xffcbb523)
                                      : Color(0xffcbb523),
                                ),
                              ),
                            ),
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _ageProg,
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _phoneProg,
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _specializationProg,
                              inputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('about', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(90),
                          child: TextField(
                            controller: _aboutProg,
                            maxLines: 3,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'write...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.scaleTextFont(13),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(48),
                          child: ElevatedButton(
                            child: TextStyleWidget('OK', Colors.white,
                                SizeConfig.scaleTextFont(22), FontWeight.bold),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await createProgAccount();
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _companyNameCom,
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
                          height: SizeConfig.scaleHeight(86),
                          child: TextField(
                            controller: _passwordCom,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              helperText:
                                  'Password must contain letters(capital & small), numbers '
                                  '\nspecial characters and not less than 8',
                              helperStyle: TextStyle(
                                fontSize: SizeConfig.scaleTextFont(12),
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText
                                      ? Color(0xffcbb523)
                                      : Color(0xffcbb523),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('confirm password', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(48),
                          child: TextField(
                            controller: _confirmPasswordCom,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText
                                      ? Color(0xffcbb523)
                                      : Color(0xffcbb523),
                                ),
                              ),
                            ),
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _phoneCom,
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
                            child: TextFieldWidget.textfieldCon(
                              controller: _addressCom,
                              inputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('manager name', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                            width: SizeConfig.scaleWidth(321),
                            height: SizeConfig.scaleHeight(48),
                            child: TextFieldWidget.textfieldCon(
                              controller: _managerCom,
                              inputType: TextInputType.text,
                            )),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        TextStyleWidget('about', Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(90),
                          child: TextField(
                            controller: _aboutCom,
                            maxLines: 3,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'write...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.scaleTextFont(13),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(20),
                        ),
                        SizedBox(
                          width: SizeConfig.scaleWidth(321),
                          height: SizeConfig.scaleHeight(48),
                          child: ElevatedButton(
                            child: TextStyleWidget('OK', Colors.white,
                                SizeConfig.scaleTextFont(22), FontWeight.bold),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await createComAccount();
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
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future createProgAccount() async {
    setState(() {
      _isLoading = true;
    });

    String phoneNumber = _phoneProg!.text;
    String password = _passwordProg!.text;

    if (_emailProg!.text.isNotEmpty &&
        _passwordProg!.text.isNotEmpty &&
        _usernameProg!.text.isNotEmpty &&
        _phoneProg!.text.isNotEmpty &&
        _ageProg!.text.isNotEmpty &&
        _specializationProg!.text.isNotEmpty &&
        _aboutProg!.text.isNotEmpty &&
        _confirmPasswordProg!.text.isNotEmpty) {
      // قيود على كلمة السر
      if (password.length >= 6 &&
          password.contains(
              RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,}$'))) {
        if (_passwordProg!.text == _confirmPasswordProg!.text) {
          // قيود على رقم الهاتف
          if (phoneNumber.length == 10 &&
              phoneNumber.startsWith('05') &&
              int.tryParse(phoneNumber) != null &&
              !phoneNumber.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            UserCredential? userCredential = await FirebaseAuthController
                .fireAuthHelper
                .createAccount(Users.signup(
                    _usernameProg!.text,
                    _emailProg!.text,
                    _passwordProg!.text,
                    _phoneProg!.text,
                    int.tryParse(_ageProg!.text),
                    _specializationProg!.text,
                    _aboutProg!.text,
                    false));

            if (userCredential != null) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return LoginScreen(
                  userType: widget.userType,
                );
              }));
            }
          } else {
            setState(() {
              _isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Please enter a valid phone number",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "the confirm Password is worng",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "Please enter a strong password",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Please Fill All Fields",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future createComAccount() async {
    setState(() {
      _isLoading = true;
    });

    String phoneNumber = _phoneCom!.text;
    String password = _passwordCom!.text;

    if (_emailCom!.text.isNotEmpty &&
        _passwordCom!.text.isNotEmpty &&
        _companyNameCom!.text.isNotEmpty &&
        _phoneCom!.text.isNotEmpty &&
        _addressCom!.text.isNotEmpty &&
        _managerCom!.text.isNotEmpty &&
        _aboutCom!.text.isNotEmpty &&
        _confirmPasswordCom!.text.isNotEmpty) {
      // قيود على كلمة السر
      if (password.length >= 6 &&
          password.contains(
              RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,}$'))) {
        if (_passwordCom!.text == _confirmPasswordCom!.text) {
          // قيود على رقم الهاتف
          if (phoneNumber.length == 10 &&
              phoneNumber.startsWith('05') &&
              int.tryParse(phoneNumber) != null &&
              !phoneNumber.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            UserCredential? userCredential = await FirebaseAuthController
                .fireAuthHelper
                .createComAccount(Company.signUP(
              _companyNameCom!.text,
              _emailCom!.text,
              _passwordCom!.text,
              _phoneCom!.text,
              _addressCom!.text,
              _managerCom!.text,
              _aboutCom!.text,
              'https://firebasestorage.googleapis.com/v0/b/prog-jobs-grad.appspot.com/o/com_images%2FwithoutImageCompany.png?alt=media&token=c072186c-21be-41be-8ade-46812dad6f81',
              'https://firebasestorage.googleapis.com/v0/b/prog-jobs-grad.appspot.com/o/com_manager_images%2FwithoutImagePerson.jpg?alt=media&token=e8b42862-f9ff-49e8-aaf2-75b4bf13f104',
            ));
            if (userCredential != null) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return ComLogoScreen(
                  comName: _companyNameCom!.text,
                );
              }));
            }
          } else {
            setState(() {
              _isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Please enter a valid phone number",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "the confirm Password is worng",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "Please enter a strong password",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Please Fill All Fields",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
