import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AcceptPersonScreen.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class NumberOfRequestsScreen extends StatefulWidget {
  static const String id = "no_of_request_screen";

  @override
  State<NumberOfRequestsScreen> createState() => _NumberOfRequestsScreenState();
}

class _NumberOfRequestsScreenState extends State<NumberOfRequestsScreen> {
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
        actions: [
          IconButton(
            onPressed: () {
              showBottomSheet(context);
            },
            icon: Icon(
              Icons.tune,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
          ),
        ],
      ),
      backgroundColor: Color(0xfffafafa),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
              child: TextStyleWidget(
                'Requests:',
                Color(0xffcbb523),
                SizeConfig.scaleTextFont(15),
                FontWeight.w500,
              ),
            ),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.scaleWidth(15)),
                            child: TextStyleWidget(
                              'Today 11:30 AM',
                              Color(0xff4C5175),
                              SizeConfig.scaleTextFont(10),
                              FontWeight.w500,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AcceptPerson();
                          }));
                        },
                        child: Container(
                            height: SizeConfig.scaleHeight(80),
                            width: SizeConfig.scaleWidth(360),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            margin: EdgeInsets.only(
                              left: SizeConfig.scaleWidth(15),
                              right: SizeConfig.scaleWidth(15),
                              bottom: SizeConfig.scaleWidth(25),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(SizeConfig.scaleWidth(8)),
                              child: Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: CircleBorder(),
                                    elevation: 4,
                                    color: Color(0xffcbb523),
                                    child: SizedBox(
                                      width: SizeConfig.scaleWidth(60),
                                      height: SizeConfig.scaleHeight(100),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/prof1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Row(
                                          children: [
                                            TextStyleWidget(
                                              'Web Programmer',
                                              Color(0xff4C5175),
                                              SizeConfig.scaleTextFont(15),
                                              FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.account_circle,
                                                  size:
                                                      SizeConfig.scaleWidth(15),
                                                  color: Color(0xffcbb523),
                                                ),
                                                TextStyleWidget(
                                                  'Sohib Naser Khalaf',
                                                  Colors.black,
                                                  SizeConfig.scaleTextFont(10),
                                                  FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size:
                                                      SizeConfig.scaleWidth(14),
                                                  color: Color(0xffcbb523),
                                                ),
                                                TextStyleWidget(
                                                  ' a minute ago',
                                                  Colors.black,
                                                  SizeConfig.scaleTextFont(10),
                                                  FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  );
                })
          ],
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
                TextStyleWidget("Filter ", Color(0xffCBB523),
                    SizeConfig.scaleTextFont(22), FontWeight.w500),
                SizedBox(
                  height: 10,
                ),
                TextStyleWidget("Date: ", Color(0xff4C5175),
                    SizeConfig.scaleTextFont(15), FontWeight.w500),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.date_range,
                        size: SizeConfig.scaleWidth(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: "19/2/2023",
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
                TextStyleWidget("Specialization ", Color(0xff4C5175),
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
                        child: TextStyleWidget("Research ", Colors.white,
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
