import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoEditScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';

import '../../customWidget/textStyleWidget.dart';
import 'ConversationScreen.dart';

class CompanyInfo extends StatefulWidget {
  static const String id = "company_info_screen";

  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/company_info_image.jpg",
                    height: SizeConfig.scaleHeight(250),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.8),
                    colorBlendMode: BlendMode.darken,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: SizeConfig.scaleWidth(30),
                              top: SizeConfig.scaleHeight(50)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: SizeConfig.scaleWidth(20),
                            ),
                          )),
                      if (UserTypeScreen.type == "company")
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig.scaleWidth(300),
                                top: SizeConfig.scaleHeight(50)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return CompanyInfoEdit();
                                }));
                              },
                              child: Icon(Icons.edit_sharp,
                                  color: Colors.white,
                                  size: SizeConfig.scaleWidth(25)),
                            ))
                      else if (UserTypeScreen.type == "programmer")
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig.scaleWidth(300),
                                top: SizeConfig.scaleHeight(50)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ConversationScreen();
                                }));
                              },
                              child: Icon(Icons.message,
                                  color: Colors.white,
                                  size: SizeConfig.scaleWidth(25)),
                            ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsetsDirectional.only(
                          top: SizeConfig.scaleHeight(170)),
                      child:
                          Image.asset("assets/images/technologyCompany.png")),
                ],
              ),
              Text(
                "Technology Magic",
                style: TextStyle(
                    color: Color(0xffCBB523),
                    fontSize: SizeConfig.scaleTextFont(18),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(30),
                    top: SizeConfig.scaleHeight(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.apartment,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(20),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(10),
                    ),
                    Text(
                      "technology magic company",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.scaleTextFont(12),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: SizeConfig.scaleWidth(30),
                  top: SizeConfig.scaleHeight(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.alternate_email,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(20),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(10),
                    ),
                    Text(
                      "technology.magic28@gmail.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.scaleTextFont(12),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(30),
                    top: SizeConfig.scaleHeight(5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(20),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(10),
                    ),
                    Text(
                      "Gaza_alNasr_Dawar Hamid",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.scaleTextFont(12),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(30),
                    top: SizeConfig.scaleHeight(5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_android,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(20),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(10),
                    ),
                    Text(
                      "0592 066 269",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.scaleTextFont(12),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(30),
                    top: SizeConfig.scaleHeight(5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.manage_accounts,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(20),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(10),
                    ),
                    Text(
                      "Company Manager",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.scaleTextFont(12),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                  top: SizeConfig.scaleHeight(20),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.scaleHeight(40),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig.scaleWidth(10)),
                        child: TextStyleWidget(
                            "About Company :",
                            Color(0xffCBB523),
                            SizeConfig.scaleTextFont(20),
                            FontWeight.w500),
                      ),
                      Container(
                        // height: SizeConfig.scaleHeight(500),
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.only(
                          top: SizeConfig.scaleHeight(10),
                          bottom: SizeConfig.scaleHeight(10),
                          start: SizeConfig.scaleWidth(10),
                          end: SizeConfig.scaleWidth(10),
                        ),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: SizeConfig.scaleHeight(10),
                              bottom: SizeConfig.scaleHeight(10),
                              start: SizeConfig.scaleWidth(10),
                              end: SizeConfig.scaleWidth(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu",
                                  maxLines: 13,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: SizeConfig.scaleTextFont(15),
                                      wordSpacing: 2),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
