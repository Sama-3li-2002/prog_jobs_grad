import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/CompanyInfoScreenProg.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/SubmitJopScreen.dart';
import '../../../model/CompanyModel.dart';
import '../../customWidget/textStyleWidget.dart';
import '../CompanyScreens/CompanyInfoScreen.dart';

class JobsDetails extends StatefulWidget {
  static const String id = "job_details_screen";
  late List<Jobs> items;
  late List<Company> itemsComInfo ;


  JobsDetails({ required this.items ,required  this.itemsComInfo});

  @override
  State<JobsDetails> createState() => _JobsDetailsState();
}

class _JobsDetailsState extends State<JobsDetails> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: SizeConfig.scaleHeight(300),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Image.asset(
                        "assets/images/image11.jpg",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.7),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CompanyInfoScreenProg(itemsComInfo: widget.itemsComInfo);
                        }));
                      },
                      child: FractionalTranslation(
                        translation: Offset(0.0, 0.5),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Image.asset (
                            widget.itemsComInfo
                                .isNotEmpty
                                ? widget.itemsComInfo[0].image ??
                                "" : "No Image",
                            height: SizeConfig.scaleHeight(120),
                            width: SizeConfig.scaleWidth(120),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                                size: SizeConfig.scaleWidth(20),
                              ),
                              color: Color(0xffD2D0D0FF),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(65),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(15),
                    ),
                    TextStyleWidget(
                        widget.itemsComInfo
                            .isNotEmpty
                            ? widget.itemsComInfo[0].address ??
                            "" : "No Address",
                        Color(0xff4C5175),
                        SizeConfig.scaleTextFont(15),
                        FontWeight.w500),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){},
                      child:
                      Image.asset(
                        "assets/images/facebook.png",
                        width: SizeConfig.scaleWidth(30),
                        height: SizeConfig.scaleHeight(30),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(15),
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: Image.asset("assets/images/twitter.png",
                          width: SizeConfig.scaleWidth(30),
                          height: SizeConfig.scaleHeight(30)),
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(15),
                    ),
                    InkWell(
                      onTap: () {
                      },
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
                        TextStyleWidget(
                            widget.items.isNotEmpty
                                ? widget.items[0].job_name ?? ""
                                : "No Job Name",
                            Color(0xffCBB523),
                            SizeConfig.scaleTextFont(20),
                            FontWeight.bold),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextStyleWidget(
                              widget.items.isNotEmpty
                                  ? widget.items[0].salary ?? ""
                                  : "No Salary",
                              Color(0xff000000),
                              SizeConfig.scaleTextFont(15),
                              FontWeight.w600),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        TextStyleWidget(
                            "Job description:",
                            Color(0xff4C5175),
                            SizeConfig.scaleTextFont(15),
                            FontWeight.w500),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextStyleWidget(
                                  widget.items.isNotEmpty
                                      ? widget.items[0].job_description ??
                                      ""
                                      : "No Job Description",
                                  Colors.black,
                                  SizeConfig.scaleTextFont(12),
                                  FontWeight.normal),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(5),
                        ),
                        TextStyleWidget(
                            "required skills:",
                            Color(0xff4C5175),
                            SizeConfig.scaleTextFont(15),
                            FontWeight.w500),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: double.infinity,),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.scaleWidth(20),
                                    top: SizeConfig.scaleHeight(10),
                                    bottom : SizeConfig.scaleHeight(10)),
                                child: TextStyleWidget(
                                    widget.items.isNotEmpty
                                        ? widget.items[0]
                                        .required_skills_one ??
                                        ""
                                        : "No required skills",
                                    Color(0xff091A20),
                                    SizeConfig.scaleTextFont(12),
                                    FontWeight.w500),
                              ),

                              if(widget.items.elementAt(0).required_skills_two!.isNotEmpty)
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity
                                      ,height: 1.5,
                                      color: Colors.grey.shade100,),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom : SizeConfig.scaleHeight(10)),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items.elementAt(0)
                                              .required_skills_two ??
                                              ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),

                              if(widget.items.elementAt(0).required_skills_three!.isNotEmpty)
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity
                                      ,height: 1.5,
                                      color: Colors.grey.shade100,),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom : SizeConfig.scaleHeight(10)
                                      ),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items[0]
                                              .required_skills_three??
                                              ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),

                              if(widget.items.elementAt(0).required_skills_four!.isNotEmpty)
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity
                                      ,height: 1.5,
                                      color: Colors.grey.shade100,),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom : SizeConfig.scaleHeight(10)
                                      ),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items[0]
                                              .required_skills_four??
                                              ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                            ],
                          ),

                        ),

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
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) {
                                  //           return SubmitJopScreen(ComId: "",itemsComInfo: [],JobId: "",);
                                  //         }));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff4C5175),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.touch_app_outlined,
                                        color: Color(0xffcbb523),
                                        size:
                                        SizeConfig.scaleWidth(20),
                                      ),
                                      SizedBox(
                                        width:
                                        SizeConfig.scaleWidth(10),
                                      ),
                                      TextStyleWidget(
                                          "Submition",
                                          Color(0xffFAFAFA),
                                          SizeConfig.scaleTextFont(
                                              13),
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
                                        color: Color(0xffCBB523),
                                        size: 19)),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ]),
        ),
      ),
      // ),
    );
  }

}


