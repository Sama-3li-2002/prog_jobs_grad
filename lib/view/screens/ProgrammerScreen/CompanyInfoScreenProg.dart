import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';


import '../../../model/CompanyModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class CompanyInfoScreenProg extends StatefulWidget {
  late List<Company> itemsComInfo;

  CompanyInfoScreenProg({required this.itemsComInfo});

  @override
  State<CompanyInfoScreenProg> createState() => _CompanyInfoScreenProgState();
}

class _CompanyInfoScreenProgState extends State<CompanyInfoScreenProg> {


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
                    height: SizeConfig.scaleHeight(220),
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
                              size: SizeConfig.scaleWidth(14),
                            ),
                          )),
                      Spacer(),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: SizeConfig.scaleWidth(20),
                              top: SizeConfig.scaleHeight(50)),
                          child: InkWell(
                            onTap: () async {
                              // to get current user name
                              Users? user= await FirebaseFireStoreHelper.fireStoreHelper.getUserData(FirebaseAuthController.fireAuthHelper.userId());
                              ConversationScreen.companyId =widget.itemsComInfo[0].id!;
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return ConversationScreen(progUsername: user!.username,widget.itemsComInfo.first.companyName!);
                                  }));
                            },
                            child: Icon(
                              Icons.chat,
                              color: Colors.white,
                              size: SizeConfig.scaleWidth(20),
                            ),
                          )),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.scaleHeight(150)),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          widget.itemsComInfo.isNotEmpty
                              ? widget.itemsComInfo[0].image ?? ""
                              : "No Image",
                          width: SizeConfig.scaleWidth(120),
                          height: SizeConfig.scaleHeight(120),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.itemsComInfo.isNotEmpty
                    ? widget.itemsComInfo[0].companyName ?? ""
                    : "No Company Name ",
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
                      widget.itemsComInfo.isNotEmpty
                          ? widget.itemsComInfo[0].companyName ?? ""
                          : "No Company Name",
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
                      widget.itemsComInfo.isNotEmpty
                          ? widget.itemsComInfo[0].email ?? ""
                          : "No Email",
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
                      widget.itemsComInfo.isNotEmpty
                          ? widget.itemsComInfo[0].address ?? ""
                          : "No Address",
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
                      widget.itemsComInfo.isNotEmpty
                          ? widget.itemsComInfo[0].phone ?? ""
                          : "No Phone Available",
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
              Container(
                // height: SizeConfig.scaleHeight(800),
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(
                  top: SizeConfig.scaleHeight(20),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 50,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(300),
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                  "assets/images/advertisement 1.jpeg"),
                              margin: EdgeInsetsDirectional.only(
                                top: SizeConfig.scaleHeight(30),
                                bottom: SizeConfig.scaleHeight(10),
                                start: SizeConfig.scaleWidth(10),
                                end: SizeConfig.scaleWidth(5),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "assets/images/advertisement 2.jpg",
                              ),
                              margin: EdgeInsetsDirectional.only(
                                top: SizeConfig.scaleHeight(30),
                                bottom: SizeConfig.scaleHeight(10),
                                start: SizeConfig.scaleWidth(5),
                                end: SizeConfig.scaleWidth(5),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "assets/images/advertisement 3.jpg",
                              ),
                              margin: EdgeInsetsDirectional.only(
                                top: SizeConfig.scaleHeight(30),
                                bottom: SizeConfig.scaleHeight(10),
                                start: SizeConfig.scaleWidth(5),
                                end: SizeConfig.scaleWidth(5),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(10),
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
                        // height: SizeConfig.scaleHeight(400),
                        // width: double.infinity,
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
                              top: SizeConfig.scaleHeight(15),
                              bottom: SizeConfig.scaleHeight(10),
                              start: SizeConfig.scaleWidth(20),
                              end: SizeConfig.scaleWidth(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        widget.itemsComInfo.isNotEmpty
                                            ? widget.itemsComInfo[0]
                                            .managerImage ??
                                            ""
                                            : "No  Manger Image",
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(15),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.scaleHeight(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextStyleWidget(
                                              widget.itemsComInfo.isNotEmpty
                                                  ? widget.itemsComInfo[0]
                                                  .managerName ??
                                                  ""
                                                  : "No Manger Name ",
                                              Colors.black,
                                              SizeConfig.scaleTextFont(18),
                                              FontWeight.w500),
                                          SizedBox(
                                            height: SizeConfig.scaleHeight(2),
                                          ),
                                          TextStyleWidget(
                                              "Company Manager:",
                                              Colors.grey,
                                              SizeConfig.scaleTextFont(14),
                                              FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(15),
                                ),
                                AutoSizeText(
                                  widget.itemsComInfo.isNotEmpty
                                      ? widget.itemsComInfo[0].about ?? ""
                                      : "No Data available",
                                  maxLines: 13,
                                  overflow: TextOverflow.ellipsis,
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