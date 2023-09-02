import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/view/customWidget/DrawerWidget.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/JobsCompanyDetailsScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ShowMessagesCom.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/no_of_request.dart';
import 'package:provider/provider.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../providers/CompanyJobsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'AddNewJobScreen.dart';
import 'com_all_jobs.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ComHomeScreen extends StatefulWidget {
  static const String id = "com_home_screen";

  @override
  State<ComHomeScreen> createState() => _ComHomeScreenState();
}

class _ComHomeScreenState extends State<ComHomeScreen> {
  //For archive Icon
  List<bool> isPressedList = [];

  List<Jobs> jobs = [];



  @override
  void initState() {
    super.initState();
     Provider.of<CompanyJobsProvider>(context, listen: false).getAllJobsObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.list,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
               Padding(
                 padding: EdgeInsetsDirectional.only(
                   top: 5
                 ),
                 child: InkWell(
                 onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ShowMessagesCom();
                  }));
                     },
                     child: Icon(Icons.chat ,
                       color: Color(0xff4C5175),
                       size: SizeConfig.scaleWidth(28) ,
                 ),

                 ),
               ),

          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AddNewJobScreen();
              }));
            },
            icon: Icon(
              Icons.add_card,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
          ),

               ],
      ),

    body: Consumer<CompanyJobsProvider>(
          builder: (context, companyJobsProvider, _) {

            companyJobsProvider.JobsList.sort(
                    (a, b) => b.current_time!.compareTo(a.current_time!));

            List<Jobs> newJobs = companyJobsProvider.JobsList.length >= 2
                ? companyJobsProvider.JobsList.sublist(0, 2)
                : companyJobsProvider.JobsList;
            print("the length $newJobs.length");


            return companyJobsProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : (companyJobsProvider.JobsList.isEmpty)
                ? Column(
                  children: [
                    AdImages(),
                    Center(
                    child: Text('No available job',
                    style: TextStyle(fontSize: 18.0),
                    ),),
                  ],
                )
                : SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdImages(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.scaleWidth(10),
                      top: SizeConfig.scaleWidth(10),
                    ),
                    child: TextStyleWidget(
                      'New Jobs:',
                      Color(0xffCBB523),
                      SizeConfig.scaleTextFont(15),
                      FontWeight.w500,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: newJobs.length,
                    itemBuilder: (BuildContext context, int index) {

                      // لازالة الثواني من الوقت
                      late String formattedTime;
                      String timeString =  newJobs[index].current_time ?? "";
                      try {
                        formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
                      } catch (e) {
                        print("Invalid data format: $timeString");
                        formattedTime = "Invalid time format";
                      }


                      if (isPressedList.length <= index) {
                        isPressedList.add(false);
                      }
                      return Container(
                        margin: EdgeInsets.all(
                          SizeConfig.scaleWidth(15),
                        ),
                        child: Material(
                          elevation: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return JobsCompanyDetailsScreen(items: [
                                          companyJobsProvider.JobsList.elementAt(
                                              index),
                                        ]);
                                      }));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.scaleHeight(110),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          )),
                                      child: Image.network(
                                        companyJobsProvider
                                            .JobsList.isNotEmpty
                                            ? companyJobsProvider
                                            .JobsList[index]
                                            .job_image ??
                                            ""
                                            : "No Image",
                                        fit: BoxFit.cover,
                                        width: SizeConfig.scaleWidth(96),
                                        height: SizeConfig.scaleHeight(105),
                                        color: Color(0xff4C5175)
                                            .withOpacity(0.5),
                                        colorBlendMode: BlendMode.darken,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                TextStyleWidget(
                                                  companyJobsProvider
                                                      .JobsList.isNotEmpty
                                                      ? companyJobsProvider
                                                      .JobsList[index]
                                                      .job_name ??
                                                      ""
                                                      : "No Job Name",
                                                  Color(0xff4C5175),
                                                  SizeConfig.scaleTextFont(
                                                      15),
                                                  FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.apartment,
                                                      size: SizeConfig
                                                          .scaleWidth(15),
                                                      color:
                                                      Color(0xffcbb523),
                                                    ),
                                                    TextStyleWidget(
                                                      companyJobsProvider
                                                          .JobsList
                                                          .isNotEmpty
                                                          ? companyJobsProvider
                                                          .JobsList[
                                                      index]
                                                          .company_name ??
                                                          ""
                                                          : "No Company Name",
                                                      Colors.black,
                                                      SizeConfig
                                                          .scaleTextFont(10),
                                                      FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.access_time,
                                                            size: SizeConfig
                                                                .scaleWidth(
                                                                14),
                                                            color: Color(
                                                                0xffcbb523),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                .scaleWidth(
                                                                3),
                                                          ),
                                                          TextStyleWidget(
                                                            companyJobsProvider
                                                                .JobsList
                                                                .isNotEmpty
                                                                ? formattedTime ??
                                                                ""
                                                                : "No Current Time",
                                                            Colors.black,
                                                            SizeConfig
                                                                .scaleTextFont(
                                                                10),
                                                            FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:  EdgeInsets.only(left: 15),
                                                        child: TextStyleWidget(
                                                          companyJobsProvider
                                                              .JobsList
                                                              .isNotEmpty
                                                              ? companyJobsProvider
                                                              .JobsList[
                                                          index]
                                                              .current_date ??
                                                              ""
                                                              : "No Current Date",
                                                          Colors.black,
                                                          SizeConfig
                                                              .scaleTextFont(
                                                              10),
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height:
                                                  SizeConfig.scaleHeight(
                                                      30),
                                                  child: ElevatedButton(
                                                    child: TextStyleWidget(
                                                      'number of requests',
                                                      Colors.white,
                                                      SizeConfig
                                                          .scaleTextFont(10),
                                                      FontWeight.w500,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return NumberOfRequestsScreen(
                                                                  jobs: companyJobsProvider
                                                                      .JobsList[
                                                                  index],
                                                                );
                                                              }));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      Color(0xff4C5175),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(2),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  icon: isPressedList[index]
                                                      ? Icon(
                                                    Icons.bookmark,
                                                    color: Color(
                                                        0xffcbb523),
                                                  )
                                                      : Icon(
                                                      Icons
                                                          .bookmark_border,
                                                      color: Color(
                                                          0xffcbb523)),
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(16.0),
                                                          ),
                                                          elevation: 0,
                                                          backgroundColor: Colors.transparent,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(16.0),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.all(16.0),
                                                                  child: Text(
                                                                    "Archive Job",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                Padding(
                                                                  padding: EdgeInsets.all(16.0),
                                                                  child: Text(
                                                                    "Are you sure you archive this job?",
                                                                    style: TextStyle(fontSize: 16),
                                                                  ),
                                                                ),
                                                                ButtonBar(
                                                                  alignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed: () async {
                                                                        setState(() {
                                                                          isPressedList[index] =
                                                                          !isPressedList[
                                                                          index];
                                                                        });
                                                                        await archiveJobs(
                                                                            companyJobsProvider
                                                                                .JobsList
                                                                                .elementAt(
                                                                                index));
                                                                        delete(companyJobsProvider
                                                                            .JobsList
                                                                            .elementAt(index)
                                                                            .job_id!);
                                                                        setState(() {
                                                                          companyJobsProvider
                                                                              .JobsList
                                                                              .removeAt(index);
                                                                        });
                                                                        Navigator.pop(context);

                                                                      },
                                                                      child: Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                          color: Colors.red,
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text(
                                                                        "No",
                                                                        style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(10),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.scaleWidth(10)),
                    child: Row(
                      children: [
                        TextStyleWidget(
                          'Available Jobs:',
                          Color(0xffcbb523),
                          SizeConfig.scaleTextFont(15),
                          FontWeight.w500,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ComAllJobScreen();
                            }));
                          },
                          child: TextStyleWidget(
                            'see all',
                            Color(0xffCB3423),
                            SizeConfig.scaleTextFont(12),
                            FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: companyJobsProvider.JobsList.length,
                    itemBuilder: (BuildContext context, int index) {

                      // لازالة الثواني من الوقت
                      late String formattedTime;
                      String timeString =  companyJobsProvider.JobsList[index].current_time ?? "";
                      try {
                        formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
                      } catch (e) {
                        print("Invalid data format: $timeString");
                        formattedTime = "Invalid time format";
                      }

                      if (isPressedList.length <= index) {
                        isPressedList.add(false);
                      }
                      return Container(
                          margin: EdgeInsets.all(
                            SizeConfig.scaleWidth(15),
                          ),
                          child: Material(
                              elevation: 2,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              JobsCompanyDetailsScreen(
                                                  items: [
                                                    companyJobsProvider.JobsList
                                                        .elementAt(index),
                                                  ]),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: SizeConfig.scaleHeight(110),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              )),
                                          child: Image.network(
                                            companyJobsProvider
                                                .JobsList.isNotEmpty
                                                ? companyJobsProvider
                                                .JobsList[index]
                                                .job_image ??
                                                ""
                                                : "No Image",
                                            fit: BoxFit.cover,
                                            width: SizeConfig.scaleWidth(96),
                                            height:
                                            SizeConfig.scaleHeight(105),
                                            color: Color(0xff4C5175)
                                                .withOpacity(0.5),
                                            colorBlendMode: BlendMode.darken,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: SizeConfig.scaleWidth(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    TextStyleWidget(
                                                      companyJobsProvider
                                                          .JobsList
                                                          .isNotEmpty
                                                          ? companyJobsProvider
                                                          .JobsList[
                                                      index]
                                                          .job_name ??
                                                          ""
                                                          : "No Job Name",
                                                      Color(0xff4C5175),
                                                      SizeConfig
                                                          .scaleTextFont(15),
                                                      FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.apartment,
                                                          size: SizeConfig
                                                              .scaleWidth(15),
                                                          color: Color(
                                                              0xffcbb523),
                                                        ),
                                                        TextStyleWidget(
                                                          companyJobsProvider
                                                              .JobsList
                                                              .isNotEmpty
                                                              ? companyJobsProvider
                                                              .JobsList[
                                                          index]
                                                              .company_name ??
                                                              ""
                                                              : "No Company Name",
                                                          Colors.black,
                                                          SizeConfig
                                                              .scaleTextFont(
                                                              10),
                                                          FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          right: 8),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time,
                                                                size: SizeConfig
                                                                    .scaleWidth(
                                                                    14),
                                                                color: Color(
                                                                    0xffcbb523),
                                                              ),
                                                              SizedBox(
                                                                width: SizeConfig
                                                                    .scaleWidth(
                                                                    3),
                                                              ),
                                                              TextStyleWidget(
                                                                companyJobsProvider
                                                                    .JobsList
                                                                    .isNotEmpty
                                                                    ? formattedTime??
                                                                    ""
                                                                    : "No Current Time",
                                                                Colors.black,
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                    10),
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:  EdgeInsets.only(left: 15),
                                                            child: TextStyleWidget(
                                                              companyJobsProvider
                                                                  .JobsList
                                                                  .isNotEmpty
                                                                  ? companyJobsProvider
                                                                  .JobsList[index]
                                                                  .current_date ??
                                                                  ""
                                                                  : "No Current Date",
                                                              Colors.black,
                                                              SizeConfig
                                                                  .scaleTextFont(
                                                                  10),
                                                              FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: SizeConfig
                                                          .scaleHeight(30),
                                                      child: ElevatedButton(
                                                        child:
                                                        TextStyleWidget(
                                                          'number of requests',
                                                          Colors.white,
                                                          SizeConfig
                                                              .scaleTextFont(
                                                              10),
                                                          FontWeight.w500,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                              context)
                                                              .push(MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return NumberOfRequestsScreen(
                                                                  jobs: companyJobsProvider
                                                                      .JobsList[
                                                                  index],
                                                                );
                                                              }));
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                          Color(
                                                              0xff4C5175),
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                2),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                      alignment: Alignment
                                                          .centerRight,
                                                      icon: isPressedList[
                                                      index]
                                                          ? Icon(
                                                        Icons.bookmark,
                                                        color: Color(
                                                            0xffcbb523),
                                                      )
                                                          : Icon(
                                                          Icons
                                                              .bookmark_border,
                                                          color: Color(
                                                              0xffcbb523)),
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(16.0),
                                                              ),
                                                              elevation: 0,
                                                              backgroundColor: Colors.transparent,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(16.0),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.all(16.0),
                                                                      child: Text(
                                                                        "Archive Job",
                                                                        style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    Padding(
                                                                      padding: EdgeInsets.all(16.0),
                                                                      child: Text(
                                                                        "Are you sure you archive this job?",
                                                                        style: TextStyle(fontSize: 16),
                                                                      ),
                                                                    ),
                                                                    ButtonBar(
                                                                      alignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed: () async {
                                                                            setState(() {
                                                                              isPressedList[index] =
                                                                              !isPressedList[
                                                                              index];
                                                                            });
                                                                            await archiveJobs(
                                                                                companyJobsProvider
                                                                                    .JobsList
                                                                                    .elementAt(
                                                                                    index));
                                                                            delete(companyJobsProvider
                                                                                .JobsList
                                                                                .elementAt(index)
                                                                                .job_id!);
                                                                            setState(() {
                                                                              companyJobsProvider
                                                                                  .JobsList
                                                                                  .removeAt(index);
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text(
                                                                            "Yes",
                                                                            style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: Text(
                                                                            "No",
                                                                            style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))));
                    },
                  ),
                ],
              ),
            );



          }
          ),
    );
  }

  Future<void> archiveJobs(Jobs jobs) async {
    DocumentReference documentReference =
    await FirebaseFireStoreHelper.instance.createArchiveJob(jobs);
    String newJobId = documentReference.id;
  }

  void delete(String jobId) {
    FirebaseFireStoreHelper.instance.deleteDocument(jobId);
  }
}

class AdImages extends StatefulWidget {
  CarouselController _carouselController = CarouselController();

  final List<String> imagePaths = [
    'assets/images/img1.jpeg',
    'assets/images/img2.jpeg',
    'assets/images/img3.jpeg',
  ];

  @override
  State<AdImages> createState() => _AdImagesState();
}

class _AdImagesState extends State<AdImages> {
  int _currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: widget._carouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlideIndex = index;
              });
            },
          ),
          items: widget.imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  width: SizeConfig.screenWidth,
                  child: Image.asset(path, fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imagePaths.map((path) {
            int index = widget.imagePaths.indexOf(path);
            return Container(
              width: SizeConfig.scaleWidth(20),
              height: SizeConfig.scaleHeight(8),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                color: _currentSlideIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}