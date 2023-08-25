import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/login.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../model/UserSettings.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "setting_screen";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showProfPic = true;
  bool recNot = true;
  String userId = FirebaseAuthController.fireAuthHelper.userId();



  // change pass
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;


  @override
  void initState() {
    super.initState();
    setState(() {
      _loadSettings();
    });

    //change pass
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextStyleWidget("Settings", Color(0xffCBB523),
                SizeConfig.scaleTextFont(15), FontWeight.w500),
            SizedBox(
              height: SizeConfig.scaleHeight(30),
            ),
            Center(
              child: Image.asset(
                "assets/images/setting_image.png",
                width: SizeConfig.scaleWidth(160),
                height: SizeConfig.scaleHeight(180),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(10),
            ),
            TextStyleWidget("Language", Color(0xffCBB523),
                SizeConfig.scaleTextFont(15), FontWeight.w500),
            SizedBox(
              height: SizeConfig.scaleHeight(7),
            ),
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.scaleWidth(20),
                      top: SizeConfig.scaleHeight(15),
                      right: SizeConfig.scaleWidth(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/UK.png"),
                        SizedBox(
                          width: SizeConfig.scaleWidth(50),
                        ),
                        TextStyleWidget(
                            "English(United kingdom)",
                            Color(0xff091A20),
                            SizeConfig.scaleTextFont(10),
                            FontWeight.w500),
                        Spacer(),
                        InkWell(
                          child: Icon(
                            Icons.verified_rounded,
                            color: Color(0xffCBB523),
                            size: SizeConfig.scaleWidth(18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.scaleWidth(20),
                        bottom: SizeConfig.scaleHeight(15)),
                    child: Row(
                      children: [
                        Image.asset("assets/images/SA.png"),
                        SizedBox(
                          width: SizeConfig.scaleWidth(50),
                        ),
                        TextStyleWidget(
                            "Arabic (Saudi Arabia)",
                            Color(0xff091A20),
                            SizeConfig.scaleTextFont(10),
                            FontWeight.w500),
                        SizedBox(
                          width: SizeConfig.scaleWidth(100),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(5),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20)),
                    child: buildPrivacyOptionRow(
                        'Show Profile Picture',
                        showProfPic,
                        (value) =>
                            _handleSwitchChange(value, '$userId-showProfPic')),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20)),
                    child: buildPrivacyOptionRow(
                        "Receive notifications",
                        recNot,
                        (value) =>
                            _handleSwitchChange(value, '$userId-recNot')),
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
          ]),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
     // visible pass
    bool _obscureTextCurrent = true;
    bool _obscureTextNew = true;
    bool _obscureTextConfirmNew = true;

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

          height: 500,
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
                TextStyleWidget("Current Password: ", Color(0xff4C5175),
                    SizeConfig.scaleTextFont(15), FontWeight.w500),
                SizedBox(
                  height: 5,
                ),

                SizedBox(
                  height: 50,
                  child: TextField(
                    controller:currentPasswordController ,
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _obscureTextCurrent
                              ?  Color(0xffcbb523)
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
                    controller:newPasswordController ,
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _obscureTextNew
                              ?  Color(0xffcbb523)
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
                    controller:confirmPasswordController ,
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _obscureTextConfirmNew
                              ?  Color(0xffcbb523)
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
                        onPressed: ()async {
                        if(await _changePassword())
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return LoginScreen(userType: "programmer");
                              }));
                        },
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
      } else if (settingKey == '$userId-recNot') {
        recNot = value;
      }
    });

    UserSettings.saveSettings(
      showProfPic,
      recNot,
      userId,
    );
  }

  Future _loadSettings() async {
    showProfPic = await UserSettings.getSetting('$userId-showProfPic');

    recNot = await UserSettings.getSetting('$userId-recNot');

    setState(() {
      buildPrivacyOptionRow('Show Profile Picture', showProfPic,
          (value) => _handleSwitchChange(value, '$userId-showProfPic'));
      buildPrivacyOptionRow("Receive notifications", recNot,
          (value) => _handleSwitchChange(value, '$userId-recNot'));
    });
  }


  //change password----------------------------------------
  Future<bool> _changePassword() async {
    late bool isCorrect ;

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

    if (await isCurrentPasswordCorrects(oldPassword) ) {

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
        isCorrect= false;
      }
    }
    return isCorrect;
  }

  Future<bool> isCurrentPasswordCorrects(String enteredCurrentPassword) async {
    User user = FirebaseAuthController.fireAuthHelper.getCurrentUser();
    return await FirebaseAuthController.fireAuthHelper.signInToChangePass(user.email!, enteredCurrentPassword);
  }
  //-----------------------------------------------------------------------------------------

}
