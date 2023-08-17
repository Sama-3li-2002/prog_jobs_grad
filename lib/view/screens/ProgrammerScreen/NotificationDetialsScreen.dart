import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class NotificationDetailsScreen extends StatefulWidget {
  static const String id = "notificatoin_details_screen";

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
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
            size: SizeConfig.scaleWidth(20),
          ),
          color: Color(0xff4C5175),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.scaleHeight(65),
            horizontal: SizeConfig.scaleWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset("assets/images/notificationDetails.png")),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.scaleWidth(30),
                  top: SizeConfig.scaleHeight(35)),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/technologyCompany.png",
                    width: SizeConfig.scaleWidth(100),
                    height: SizeConfig.scaleHeight(100),
                  ),
                  Column(
                    children: [
                      TextStyleWidget("technology magic", Color(0xffCBB523),
                          SizeConfig.scaleTextFont(15), FontWeight.w600),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Color(0xffCBB523),
                            size: SizeConfig.scaleWidth(15),
                          ),
                          TextStyleWidget(
                              "Gaza_alNasr_Dawar Hamid",
                              Color(0xff4C5175),
                              SizeConfig.scaleTextFont(15),
                              FontWeight.w500),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(thickness: SizeConfig.scaleWidth(2)),
            Align(
              alignment: Alignment.centerRight,
              child: TextStyleWidget("Today 11:30 AM", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(11), FontWeight.w500),
            ),
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                height: SizeConfig.scaleHeight(165),
                width: SizeConfig.scaleWidth(360),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    TextStyleWidget(
                        "Eng: Sohib Naser Khalaf",
                        Color(0xffCBB523),
                        SizeConfig.scaleTextFont(15),
                        FontWeight.w600),
                    SizedBox(
                      height: SizeConfig.scaleHeight(30),
                    ),
                    TextStyleWidget(
                        "Your application has been"
                        " accepted at Magic Company. Please"
                        " apply to the company for an interview "
                        "and agree on the details.",
                        Color(0xff000000),
                        SizeConfig.scaleTextFont(15),
                        FontWeight.normal),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
