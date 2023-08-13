import 'package:flutter/material.dart';

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
            size: SizeConfig.scaleWidth(14),
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
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(20),
                        vertical: SizeConfig.scaleHeight(10)),
                    child: TextStyleWidget("Change Password", Color(0xff091A20),
                        SizeConfig.scaleTextFont(12), FontWeight.w500),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
