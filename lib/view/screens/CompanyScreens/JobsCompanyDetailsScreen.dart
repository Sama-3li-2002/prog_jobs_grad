import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:provider/provider.dart';

import '../../../model/JobsModel.dart';
import '../../../providers/ComInfoProvider.dart';
import '../../customWidget/textStyleWidget.dart';
import 'EditJobScreen.dart';

class JobsCompanyDetailsScreen extends StatefulWidget {
  static const String id = "job_com_details_screen";
  late List<Jobs> items;

  JobsCompanyDetailsScreen({required this.items});

  @override
  State<JobsCompanyDetailsScreen> createState() =>
      _JobsCompanyDetailsScreenState();
}

class _JobsCompanyDetailsScreenState extends State<JobsCompanyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ComInfoProvider>(context, listen: false).getComInfoObjects();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Consumer<ComInfoProvider>(
          builder: (context, comInfoProvider, _) => comInfoProvider
                  .comInfoList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                                  return CompanyInfo();
                                }));
                              },
                              child: FractionalTranslation(
                                translation: Offset(0.0, 0.5),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: comInfoProvider.comInfoList.isNotEmpty
                                      ? Image.network(
                                          comInfoProvider.comInfoList[0].image!,
                                          height: SizeConfig.scaleHeight(120),
                                          width: SizeConfig.scaleWidth(120),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/withoutImageCompany.png',
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
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditJobScreen(
                                              jobInfo: widget.items);
                                        }));
                                      },
                                      icon: Icon(
                                        Icons.edit_calendar_rounded,
                                        size: SizeConfig.scaleWidth(25),
                                      ),
                                      color: Color(0xffD2D0D0FF))
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
                              Icons.apartment,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(15),
                            ),
                            TextStyleWidget(
                                comInfoProvider.comInfoList.isNotEmpty
                                    ? comInfoProvider
                                            .comInfoList[0].companyName ??
                                        ""
                                    : "No Company Name",
                                Color(0xff4C5175),
                                SizeConfig.scaleTextFont(15),
                                FontWeight.w500),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
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
                                          ? widget.items[0].salary! +
                                                  "" +
                                                  r"$/month" ??
                                              ""
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
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items[0]
                                                      .job_description ??
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
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeConfig.scaleWidth(20),
                                            top: SizeConfig.scaleHeight(10),
                                            bottom: SizeConfig.scaleHeight(10)),
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
                                      if (widget.items
                                              .elementAt(0)
                                              .required_skills_two !=
                                          "")
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 1.5,
                                              color: Colors.grey.shade100,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(20),
                                                  top: SizeConfig.scaleHeight(
                                                      10),
                                                  bottom:
                                                      SizeConfig.scaleHeight(
                                                          10)),
                                              child: TextStyleWidget(
                                                  widget.items.isNotEmpty
                                                      ? widget.items
                                                              .elementAt(0)
                                                              .required_skills_two ??
                                                          ""
                                                      : "No required skills",
                                                  Color(0xff091A20),
                                                  SizeConfig.scaleTextFont(12),
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      if (widget.items
                                              .elementAt(0)
                                              .required_skills_three !=
                                          "")
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 1.5,
                                              color: Colors.grey.shade100,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(20),
                                                  top: SizeConfig.scaleHeight(
                                                      10),
                                                  bottom:
                                                      SizeConfig.scaleHeight(
                                                          10)),
                                              child: TextStyleWidget(
                                                  widget.items.isNotEmpty
                                                      ? widget.items[0]
                                                              .required_skills_three ??
                                                          ""
                                                      : "No required skills",
                                                  Color(0xff091A20),
                                                  SizeConfig.scaleTextFont(12),
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      if (widget.items
                                              .elementAt(0)
                                              .required_skills_four !=
                                          "")
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 1.5,
                                              color: Colors.grey.shade100,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(20),
                                                  top: SizeConfig.scaleHeight(
                                                      10),
                                                  bottom:
                                                      SizeConfig.scaleHeight(
                                                          10)),
                                              child: TextStyleWidget(
                                                  widget.items.isNotEmpty
                                                      ? widget.items[0]
                                                              .required_skills_four ??
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
                              ]),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }
}
