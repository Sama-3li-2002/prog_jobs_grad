import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class EditJobScreen extends StatefulWidget {
  static const String id = "edit_job_screen";

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/images/laptops.png",
                        fit: BoxFit.cover),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.asset("assets/images/technologyCompany.png",
                        height: SizeConfig.scaleHeight(90),
                        width: SizeConfig.scaleWidth(120)),
                    Image.asset(
                      "assets/images/addJobIcon.png",
                      height: SizeConfig.scaleHeight(17),
                      width: SizeConfig.scaleWidth(27),
                    ),
                  ],
                ),
                Positioned(
                  width: SizeConfig.screenWidth,
                  top: 10,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.scaleWidth(14),
                          ),
                          color: Color(0xffD2D0D0FF),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Color(0xffCBB523),
                  size: SizeConfig.scaleWidth(15),
                ),
                TextStyleWidget("Gaza_alNasr_Dawar Hamid", Color(0xff4C5175),
                    SizeConfig.scaleWidth(12), FontWeight.w500),
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/facebook.png",
                    width: SizeConfig.scaleWidth(30),
                    height: SizeConfig.scaleHeight(30),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(15),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/images/twitter.png",
                      width: SizeConfig.scaleWidth(30),
                      height: SizeConfig.scaleHeight(30)),
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(15),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/images/instagram.png",
                      width: SizeConfig.scaleWidth(30),
                      height: SizeConfig.scaleHeight(30)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget("Web programmer", Color(0xffCBB523),
                        SizeConfig.scaleTextFont(18), FontWeight.bold),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextStyleWidget("700.000/month", Color(0xff000000),
                          SizeConfig.scaleTextFont(12), FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    TextStyleWidget("wage adjustment:", Color(0xff4C5175),
                        SizeConfig.scaleTextFont(14), FontWeight.w500),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.scaleWidth(8)),
                        child: SizedBox(
                          width: SizeConfig.scaleWidth(360),
                          height: SizeConfig.scaleHeight(55),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write..',
                                hintStyle: TextStyle(
                                  fontSize: SizeConfig.scaleTextFont(12),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    TextStyleWidget("Job description:", Color(0xff4C5175),
                        SizeConfig.scaleTextFont(14), FontWeight.w500),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: SizeConfig.scaleWidth(360),
                          height: SizeConfig.scaleHeight(150),
                          child: TextField(
                            maxLines: 11,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu',
                                hintStyle: TextStyle(
                                  fontSize: SizeConfig.scaleTextFont(10),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    Row(
                      children: [
                        TextStyleWidget("required skills:", Color(0xff4C5175),
                            SizeConfig.scaleTextFont(14), FontWeight.w500),
                        Spacer(),
                        Container(
                          width: SizeConfig.scaleWidth(90),
                          height: SizeConfig.scaleHeight(20),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff4C5175),
                            ),
                            child: Row(children: [
                              // Icon(Icons.add),
                              Image.asset("assets/images/add.png"),
                              SizedBox(
                                width: SizeConfig.scaleWidth(7),
                              ),
                              TextStyleWidget("Add Skils", Color(0xffFAFAFA),
                                  SizeConfig.scaleTextFont(9), FontWeight.w500)
                            ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
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
                            padding: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(20),
                                top: SizeConfig.scaleHeight(10)),
                            child: TextStyleWidget(
                                "Website programming",
                                Color(0xff091A20),
                                SizeConfig.scaleTextFont(11),
                                FontWeight.w500),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.scaleWidth(20),
                            ),
                            child: TextStyleWidget(
                                "Website design",
                                Color(0xff091A20),
                                SizeConfig.scaleTextFont(11),
                                FontWeight.w500),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(20)),
                            child: TextStyleWidget(
                                "web services",
                                Color(0xff091A20),
                                SizeConfig.scaleTextFont(11),
                                FontWeight.w500),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(20),
                                bottom: SizeConfig.scaleHeight(10)),
                            child: TextStyleWidget(
                                "web development",
                                Color(0xff091A20),
                                SizeConfig.scaleTextFont(11),
                                FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/add.png",
                            color: Color(0xff4C5175)),
                        SizedBox(
                          width: SizeConfig.scaleWidth(5),
                        ),
                        TextStyleWidget("Add Skill:", Color(0xff4C5175),
                            SizeConfig.scaleTextFont(12), FontWeight.w500),
                      ],
                    ),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.scaleWidth(8)),
                        child: SizedBox(
                          width: SizeConfig.scaleWidth(360),
                          height: SizeConfig.scaleHeight(55),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write..',
                                hintStyle: TextStyle(
                                  fontSize: SizeConfig.scaleTextFont(12),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(15)),
                    Center(
                      child: Container(
                        width: SizeConfig.scaleWidth(350),
                        height: SizeConfig.scaleHeight(48),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ComHomeScreen();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff4C5175),
                            ),
                            child: TextStyleWidget("Save", Color(0xffFAFAFA),
                                SizeConfig.scaleTextFont(17), FontWeight.w700)),
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
