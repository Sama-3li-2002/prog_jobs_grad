import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/NotificationsScreen.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class NotificationDetailsScreen extends StatefulWidget {
  static const String id = "notificatoin_details_screen";

  Company comInfo;

  String notiContent;
  String time;
  String date;

  NotificationDetailsScreen({
    required this.comInfo,
    required this.notiContent,
    required this.time,
    required this.date,
  });

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  String? progName;

  @override
  void initState() {
    super.initState();
    setState(() {
      getProgName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return NotificationScreen();
            }));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(20),
          ),
          color: Color(0xff4C5175),
        ),
      ),
      body: progName == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.scaleHeight(65),
                  horizontal: SizeConfig.scaleWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child:
                          Image.asset("assets/images/notificationDetails.png")),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.scaleWidth(30),
                        top: SizeConfig.scaleHeight(35)),
                    child: Row(
                      children: [
                        Image.network(
                          widget.comInfo.image!,
                          width: SizeConfig.scaleWidth(100),
                          height: SizeConfig.scaleHeight(100),
                        ),
                        Column(
                          children: [
                            TextStyleWidget(
                                widget.comInfo.companyName!,
                                Color(0xffCBB523),
                                SizeConfig.scaleTextFont(15),
                                FontWeight.w600),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  color: Color(0xffCBB523),
                                  size: SizeConfig.scaleWidth(15),
                                ),
                                TextStyleWidget(
                                    widget.comInfo.address!,
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
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextStyleWidget(widget.time, Color(0xff4C5175),
                          SizeConfig.scaleTextFont(11), FontWeight.w500),
                    ),
                  ),
                  Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: SizeConfig.scaleWidth(360),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          TextStyleWidget(
                              "Dear " + progName!,
                              Color(0xffCBB523),
                              SizeConfig.scaleTextFont(15),
                              FontWeight.w600),
                          SizedBox(
                            height: SizeConfig.scaleHeight(30),
                          ),
                          TextStyleWidget(widget.notiContent, Color(0xff000000),
                              SizeConfig.scaleTextFont(15), FontWeight.normal),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future getProgName() async {
    String name;
    name = await FirebaseFireStoreHelper.instance.getProgName();
    setState(() {
      progName = name;
    });
  }
}
