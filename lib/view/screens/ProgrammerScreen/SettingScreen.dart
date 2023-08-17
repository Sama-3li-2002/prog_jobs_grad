import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/otp_code.dart';

import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class SettingScreen extends StatefulWidget {
  static const String id = "setting_screen";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                    child: Row(
                      children: [
                        TextStyleWidget(
                            "Show profile picture",
                            Color(0xff091A20),
                            SizeConfig.scaleTextFont(12),
                            FontWeight.w500),
                        Spacer(),
                        InkWell(
                          child: Icon(
                            Icons.toggle_on_outlined,
                            color: Color(0xffCBB523),
                            size: SizeConfig.scaleWidth(30),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20)),
                    child: Row(
                      children: [
                        TextStyleWidget(
                            "Receive notifications",
                            Color(0xff091A20),
                            SizeConfig.scaleTextFont(12),
                            FontWeight.w500),
                        Spacer(),
                        InkWell(
                          child: Icon(Icons.toggle_on_outlined,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(30)),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20)),
                    child: Row(
                      children: [
                        TextStyleWidget(
                            "Show Last seen And Online",
                            Color(0xff091A20),
                            SizeConfig.scaleTextFont(12),
                            FontWeight.w500),
                        Spacer(),
                        InkWell(
                          child: Icon(Icons.toggle_on_outlined,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(30)),
                        )
                      ],
                    ),
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
                      vertical: SizeConfig.scaleHeight(10)),
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
                TextStyleWidget("Old Password: ", Color(0xff4C5175),
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
