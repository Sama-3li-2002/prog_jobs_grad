import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';

import '../../customWidget/textStyleWidget.dart';
import '../CompanyScreens/EditJobScreen.dart';
import 'SubmitJopScreen.dart';

class JobDetailsScreen extends StatefulWidget {
  static const String id = "job_details_screen";

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
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
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CompanyInfo();
                    }));
                  },
                  child: Image.asset("assets/images/technologyCompany.png",
                      height: SizeConfig.scaleHeight(90),
                      width: SizeConfig.scaleWidth(120)),
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
                      if (UserTypeScreen.type == 'programmer')
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
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
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      else if (UserTypeScreen.type == 'company')
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditJobScreen();
                              }));
                            },
                            icon: Icon(
                              Icons.edit_calendar_rounded,
                              size: SizeConfig.scaleWidth(22),
                            ),
                            color: Color(0xffD2D0D0FF))
                    ],
                  ),
                )
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
                    SizeConfig.scaleTextFont(13), FontWeight.w500),
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
                        SizeConfig.scaleTextFont(20), FontWeight.bold),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextStyleWidget("700.000/month", Color(0xff000000),
                          SizeConfig.scaleTextFont(15), FontWeight.w600),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    TextStyleWidget("Job description:", Color(0xff4C5175),
                        SizeConfig.scaleTextFont(15), FontWeight.w500),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextStyleWidget(
                            "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu",
                            Colors.black,
                            SizeConfig.scaleTextFont(12),
                            FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    TextStyleWidget("required skills:", Color(0xff4C5175),
                        SizeConfig.scaleTextFont(15), FontWeight.w500),
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
                                SizeConfig.scaleTextFont(12),
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
                                SizeConfig.scaleTextFont(12),
                                FontWeight.w500),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(20)),
                            child: TextStyleWidget(
                                "web services",
                                Color(0xff091A20),
                                SizeConfig.scaleTextFont(12),
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
                                SizeConfig.scaleTextFont(12),
                                FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    if (UserTypeScreen.type == 'programmer')
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(15),
                                top: SizeConfig.scaleHeight(15)),
                            width: SizeConfig.scaleWidth(190),
                            height: SizeConfig.scaleHeight(35),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SubmitJopScreen();
                                }));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff4C5175),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.touch_app_outlined,
                                      color: Color(0xffcbb523),
                                      size: SizeConfig.scaleWidth(20),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(5),
                                    ),
                                    TextStyleWidget(
                                        "submit request",
                                        Color(0xffFAFAFA),
                                        SizeConfig.scaleTextFont(13),
                                        FontWeight.w500)
                                  ]),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.scaleWidth(15),
                                top: SizeConfig.scaleHeight(15)),
                            width: SizeConfig.scaleWidth(50),
                            height: SizeConfig.scaleHeight(35),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff4C5175),
                              ),
                              child: Center(
                                  child: Icon(Icons.favorite_border,
                                      color: Color(0xffCBB523), size: 19)),
                            ),
                          ),
                        ],
                      ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
