import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoEditScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';

import '../../customWidget/textStyleWidget.dart';

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
                                  size: SizeConfig.scaleWidth(20)),
                            )),
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
              Container(
                height: SizeConfig.scaleHeight(1000),
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(
                  top: SizeConfig.scaleHeight(20),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      // لون التأثير وشفافيته
                      spreadRadius: 5,
                      // انتشار التأثير (المسافة بين التأثير والعنصر)
                      blurRadius: 7,
                      // تحديد قوة التأثير (التموج)
                      offset: Offset(0, 3), // مكان بدء التأثير (X, Y)
                    ),
                  ],
                ),
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: SizeConfig.scaleHeight(6),
                      //   margin: EdgeInsetsDirectional.only(
                      //     top: SizeConfig.scaleHeight(20),
                      //     start: SizeConfig.scaleWidth(142),
                      //     end: SizeConfig.scaleWidth(142),
                      //   ), // هامش أفقي
                      //   decoration: BoxDecoration(
                      //     color: Color(0xff4C5175), // لون الخط
                      //     borderRadius: BorderRadius.circular(
                      //         5), // نصف قطر الزاوية المستديرة
                      //   ),
                      // ),
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
                        height: SizeConfig.scaleHeight(500),
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
                              top: SizeConfig.scaleHeight(15),
                              bottom: SizeConfig.scaleHeight(10),
                              start: SizeConfig.scaleWidth(10),
                              end: SizeConfig.scaleWidth(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/company_manger.png'),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(15),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextStyleWidget(
                                            "Eng:Ahmed Khaled Saed",
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
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(15),
                                ),
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
