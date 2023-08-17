import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';

import '../../customWidget/textStyleWidget.dart';

class AcceptPerson extends StatefulWidget {
  static const String id = "accept_person_screen";

  @override
  State<AcceptPerson> createState() => _AcceptPersonState();
}

class _AcceptPersonState extends State<AcceptPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ConversationScreen();
              }));
            },
            icon: Icon(
              Icons.message,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(),
                color: Color(0xffcbb523),
                child: SizedBox(
                  width: SizeConfig.scaleWidth(150),
                  height: SizeConfig.scaleHeight(150),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/prof1.png',
                      fit: BoxFit.cover,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(10)),
              Column(
                children: [
                  Container(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.scaleHeight(30),
                            left: SizeConfig.scaleWidth(20),
                            right: SizeConfig.scaleWidth(20)),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextStyleWidget(
                                      "Programmer's name:",
                                      Color(0xffCBB523),
                                      SizeConfig.scaleTextFont(17),
                                      FontWeight.w500),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(10),
                                  ),
                                  TextStyleWidget(
                                      "Sohib Naesr Khalaf",
                                      Colors.black,
                                      SizeConfig.scaleTextFont(15),
                                      FontWeight.w500),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              Row(
                                children: [
                                  TextStyleWidget(
                                      "E_Mail:",
                                      Color(0xffCBB523),
                                      SizeConfig.scaleTextFont(17),
                                      FontWeight.w500),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(10),
                                  ),
                                  TextStyleWidget(
                                      "sohibnkhalaf@gmail.com",
                                      Colors.black,
                                      SizeConfig.scaleTextFont(15),
                                      FontWeight.w500),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              Row(
                                children: [
                                  TextStyleWidget(
                                      "Specialization:",
                                      Color(0xffCBB523),
                                      SizeConfig.scaleTextFont(17),
                                      FontWeight.w500),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(10),
                                  ),
                                  TextStyleWidget(
                                      "Web Programmer",
                                      Colors.black,
                                      SizeConfig.scaleTextFont(15),
                                      FontWeight.w500),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              Row(
                                children: [
                                  TextStyleWidget(
                                      "Age:",
                                      Color(0xffCBB523),
                                      SizeConfig.scaleTextFont(17),
                                      FontWeight.w500),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(10),
                                  ),
                                  TextStyleWidget(
                                      "24 year's old",
                                      Colors.black,
                                      SizeConfig.scaleTextFont(15),
                                      FontWeight.w500),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              Row(
                                children: [
                                  TextStyleWidget(
                                      "Phone:",
                                      Color(0xffCBB523),
                                      SizeConfig.scaleTextFont(17),
                                      FontWeight.w500),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(10),
                                  ),
                                  TextStyleWidget(
                                      "0597768136",
                                      Colors.black,
                                      SizeConfig.scaleTextFont(15),
                                      FontWeight.w500),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(30),
                              ),
                              TextStyleWidget(
                                  "About : ",
                                  Color(0xffCBB523),
                                  SizeConfig.scaleTextFont(17),
                                  FontWeight.w500),
                              SizedBox(
                                height: SizeConfig.scaleHeight(5),
                              ),
                              Container(
                                  width: double.infinity,
                                  // height: SizeConfig.scaleHeight(300),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.scaleWidth(10),
                                        top: SizeConfig.scaleHeight(17),
                                        bottom: SizeConfig.scaleHeight(15),
                                        right: SizeConfig.scaleWidth(10)),
                                    child: Text(
                                      "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu",
                                      maxLines: 15,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.scaleTextFont(15),
                                          color: Colors.black,
                                          wordSpacing: 4),
                                    ),
                                  )),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              TextStyleWidget(
                                  "CV : ",
                                  Color(0xffCBB523),
                                  SizeConfig.scaleTextFont(17),
                                  FontWeight.w500),
                              SizedBox(
                                height: SizeConfig.scaleHeight(5),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: SizeConfig.scaleHeight(60),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(10),
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(10),
                                      ),
                                      Text(
                                        "Sohib Naesr Khalaf.pdf",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(15),
                                            color: Colors.black,
                                            wordSpacing: 4),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: SizeConfig.scaleHeight(20),
                              ),
                              Row(
                                children: [
                                  Container(
                                    // height: SizeConfig.scaleHeight(50),
                                    width: SizeConfig.scaleWidth(150),
                                    // margin: EdgeInsetsDirectional.only(start:SizeConfig.scaleWidth(250)),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xff4C5175),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: TextStyleWidget(
                                            "Accept ",
                                            Colors.white,
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(35),
                                  ),
                                  Container(
                                    // height: SizeConfig.scaleHeight(50),
                                    width: SizeConfig.scaleWidth(150),
                                    // margin: EdgeInsetsDirectional.only(start:SizeConfig.scaleWidth(250)),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xff4C5175),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: TextStyleWidget(
                                            "Reject ",
                                            Colors.white,
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
