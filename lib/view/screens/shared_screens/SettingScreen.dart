import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/home.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/login.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UserSettings.dart';
import '../../../model/UsersModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "setting_screen";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showProfPic = true;
  String userId = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;
  Users? users;

  // change pass
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    setState(() {
      getUser();
      _loadSettings();
    });
    //change pass
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  Future<void> getUser() async {
    final userResult = await fireStoreHelper.getUserData(userId);
    setState(() {
      users = userResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xffF5F5F5),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              if (UserTypeScreen.type == 'programmer') {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.scaleWidth(20),
            ),
            color: Color(0xff4C5175),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextStyleWidget("Settings", Color(0xffCBB523),
                  SizeConfig.scaleTextFont(15), FontWeight.w500),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
              Center(
                child: Image.asset(
                  "assets/images/setting_image.png",
                  width: SizeConfig.scaleWidth(200),
                  height: SizeConfig.scaleHeight(200),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(70),
              ),
              TextStyleWidget("privacy & security", Color(0xffCBB523),
                  SizeConfig.scaleTextFont(15), FontWeight.w500),
              SizedBox(
                height: SizeConfig.scaleHeight(5),
              ),
              Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (UserTypeScreen.type == 'programmer')
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(20),
                                vertical: SizeConfig.scaleHeight(10)),
                            child: buildPrivacyOptionRow(
                                'Show Profile Picture',
                                showProfPic,
                                (value) => _handleSwitchChange(
                                    value, '$userId-showProfPic')),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showBottomSheet(context);
                },
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20),
                        vertical: SizeConfig.scaleHeight(15)),
                    child: Row(
                      children: [
                        Icon(Icons.lock_reset,
                            color: Color(0xffCBB523),
                            size: SizeConfig.scaleWidth(22)),
                        SizedBox(
                          width: SizeConfig.scaleWidth(10),
                        ),
                        TextStyleWidget("Change Password", Color(0xff091A20),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDeleteDialog(context);
                },
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20),
                        vertical: SizeConfig.scaleHeight(15)),
                    child: Row(
                      children: [
                        Icon(Icons.delete_forever,
                            color: Color(0xffCBB523),
                            size: SizeConfig.scaleWidth(22)),
                        SizedBox(
                          width: SizeConfig.scaleWidth(10),
                        ),
                        TextStyleWidget("Delete My Account", Color(0xff091A20),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return PasswordChangeSheet(); // Use the StatefulWidget for the bottom sheet content.
      },
    );
  }

  Row buildPrivacyOptionRow(
    String title,
    bool val,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        TextStyleWidget(
          title,
          Color(0xff091A20),
          SizeConfig.scaleTextFont(12),
          FontWeight.w500,
        ),
        Spacer(),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: val,
            activeColor: Color(0xffCBB523),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _handleSwitchChange(bool value, String settingKey) {
    setState(() {
      if (settingKey == '$userId-showProfPic') {
        showProfPic = value;
        users!.showProfPic = value;
        fireStoreHelper.SaveUserData(users!, userId);
      }
    });

    UserSettings.saveSettings(
      showProfPic,
      userId,
    );
  }

  Future _loadSettings() async {
    showProfPic = await UserSettings.getSetting('$userId-showProfPic');
    users!.showProfPic = showProfPic;

    setState(() {
      buildPrivacyOptionRow('Show Profile Picture', showProfPic,
          (value) => _handleSwitchChange(value, '$userId-showProfPic'));
    });
  }
}

class PasswordChangeSheet extends StatefulWidget {
  const PasswordChangeSheet({super.key});

  @override
  State<PasswordChangeSheet> createState() => _PasswordChangeSheetState();
}

class _PasswordChangeSheetState extends State<PasswordChangeSheet> {
  // change pass
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  // visible pass
  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirmNew = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //change pass
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.scaleHeight(500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: SizeConfig.scaleHeight(10),
            // bottom: SizeConfig.scaleHeight(10),
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
              TextStyleWidget("Current Password: ", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(15), FontWeight.w500),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: currentPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextCurrent,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextCurrent = !_obscureTextCurrent;
                        });
                      },
                      child: Icon(
                        _obscureTextCurrent
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _obscureTextCurrent
                            ? Color(0xffcbb523)
                            : Color(0xffcbb523),
                      ),
                    ),
                  ),
                ),
              ),
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
                  controller: newPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextNew,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextNew = !_obscureTextNew;
                        });
                      },
                      child: Icon(
                        _obscureTextNew
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _obscureTextNew
                            ? Color(0xffcbb523)
                            : Color(0xffcbb523),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextStyleWidget("Confirm Password: ", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(15), FontWeight.w500),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextConfirmNew,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextConfirmNew = !_obscureTextConfirmNew;
                        });
                      },
                      child: Icon(
                        _obscureTextConfirmNew
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _obscureTextConfirmNew
                            ? Color(0xffcbb523)
                            : Color(0xffcbb523),
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
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff4C5175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (await _changePassword())
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen(userType:UserTypeScreen.type!);
                          }));
                      },
                      child: TextStyleWidget("Save ", Colors.white,
                          SizeConfig.scaleTextFont(20), FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //change password----------------------------------------
  Future<bool> _changePassword() async {
    late bool isCorrect;

    String oldPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      Fluttertoast.showToast(
        msg: "the confirm Password is worng",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }

    if (await isCurrentPasswordCorrects(oldPassword)) {
      try {
        User user = FirebaseAuthController.fireAuthHelper.getCurrentUser();
        await user.updatePassword(newPassword);
        Fluttertoast.showToast(
          msg: "Password changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        isCorrect = true;
      } catch (e) {
        print("Error changing password: $e");
        isCorrect = false;
      }
    }
    return isCorrect;
  }

  Future<bool> isCurrentPasswordCorrects(String enteredCurrentPassword) async {
    User user = FirebaseAuthController.fireAuthHelper.getCurrentUser();
    return await FirebaseAuthController.fireAuthHelper
        .signInToChangePass(user.email!, enteredCurrentPassword);
  }
}

void showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 23,
                      color: Color(0xffcbb523),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Are you sure you want to delete your account?",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _deleteAccount(context);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<SignInResult> _showSignInScreen(BuildContext context) async {
  // Delete Account
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  try {
    SignInResult signInResult = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextStyleWidget(
              "Sign In Again", Colors.black, 20, FontWeight.w500),
          content: Container(
            height: SizeConfig.scaleHeight(180),
            width: SizeConfig.scaleWidth(300),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 15,
                      color: Color(0xffcbb523),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(7),
                    ),
                    TextStyleWidget(
                        "For security reasons,"
                        " please sign in again.",
                        Colors.red.shade400,
                        11,
                        FontWeight.w500),
                  ],
                ),
                SizedBox(height: SizeConfig.scaleHeight(20)),
                SizedBox(
                  height: SizeConfig.scaleHeight(50),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          size: 15,
                        ),
                        labelStyle:
                            TextStyle(fontFamily: "Poppins", fontSize: 10)),
                    controller: _emailController,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(20),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(50),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.key,
                          size: 15,
                        ),
                        labelStyle:
                            TextStyle(fontFamily: "Poppins", fontSize: 10)),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  await FirebaseAuth.instance.currentUser!
                      .reauthenticateWithCredential(credential);

                  Navigator.pop(context, SignInResult.success);
                } catch (e) {
                  print('Error re-authenticating user: $e');
                  Navigator.pop(context, SignInResult.error);
                }
              },
              child: Text(
                'Sign In',
                style: TextStyle(fontFamily: "Poppins"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, SignInResult.cancelled);
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: "Poppins"),
              ),
            ),
          ],
        );
      },
    );

    return signInResult;
  } catch (e) {
    print('Error showing sign-in screen: $e');
    return SignInResult.error;
  }
}

Future<void> _deleteAccount(BuildContext context) async {
  try {
    SignInResult signInResult = await _showSignInScreen(context);

    if (signInResult == SignInResult.success) {
      _performAccountDeletion(context);
      Fluttertoast.showToast(
        msg: "Account deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (signInResult == SignInResult.cancelled) {
      Fluttertoast.showToast(
        msg: "Sign-in cancelled by user",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (signInResult == SignInResult.error) {
      print('Error re-authenticating user');

      Fluttertoast.showToast(
        msg: "The password is invalid",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    print('Error deleting account: $e');
  }
}

Future _performAccountDeletion(BuildContext context) async {
  try {
    if (UserTypeScreen.type == 'programmer') {
      await FirebaseFireStoreHelper.instance
          .deleteProgData(FirebaseAuthController.fireAuthHelper.userId());
    } else if (UserTypeScreen.type == 'company') {
      await FirebaseFireStoreHelper.instance
          .deleteComData(FirebaseAuthController.fireAuthHelper.userId());
    }
    await FirebaseAuth.instance.currentUser!.delete();
    // Navigator.pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return UserTypeScreen();
    }));
  } catch (e) {
    print('Error deleting account: $e');
  }
}

enum SignInResult {
  success,
  cancelled,
  error,
}
