import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'NotificationDetialsScreen.dart';
import 'ProfileInfoScreen.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = "notificatoin_screen";

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(22),
            ),
            color: Color(0xff4C5175),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProfileInfo();
              }));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: CircleBorder(),
              elevation: 4,
              color: Color(0xffcbb523),
              child: SizedBox(
                width: SizeConfig.scaleWidth(25),
                height: SizeConfig.scaleHeight(25),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/prof1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleWidget("Notifications", Color(0xffCBB523),
                SizeConfig.scaleTextFont(20), FontWeight.w600),
            // SizedBox(height: SizeConfig.scaleHeight(5)),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextStyleWidget(
                            "Today 11:30 AM",
                            Color(0xff4C5175),
                            SizeConfig.scaleTextFont(11),
                            FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return NotificationDetailsScreen();
                          }));
                        },
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.darken),
                                      child: Image.asset(
                                        "assets/images/computer.png",
                                        width: SizeConfig.scaleWidth(85),
                                        height: SizeConfig.scaleHeight(97),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: SizeConfig.scaleHeight(0),
                                    left: SizeConfig.scaleWidth(0),
                                    bottom: SizeConfig.scaleHeight(120),
                                    right: SizeConfig.scaleWidth(120),
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.notifications_active_rounded),
                                      onPressed: () {},
                                      color: Colors.white,
                                      iconSize: SizeConfig.scaleWidth(22),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(2),
                              ),
                              Container(
                                width: SizeConfig.scaleWidth(0.5),
                                height: SizeConfig.scaleHeight(90),
                                color: Color(0xff4C5175),
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(10),
                              ),
                              Expanded(
                                  child: TextStyleWidget(
                                      "Excepteur Sint Occaecat Cupidatat Non Proident, Sunt In Culpa Qui Officia Deserunt Mollit Anim Id Est Eopksio Laborum....",
                                      Color(0xff4C5175),
                                      SizeConfig.scaleTextFont(11),
                                      FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
