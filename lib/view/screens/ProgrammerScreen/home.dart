import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';
import 'package:prog_jobs_grad/providers/CompanyJobsProvider.dart';

import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:provider/provider.dart';
import '../../../model/JobsModel.dart';
import '../../../providers/CompaniesJobsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/DrawerWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'JobDetailsScreen.dart';
import 'SubmitJopScreen.dart';
import 'all_jobs.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String id = FirebaseAuthController.fireAuthHelper.userId();

  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;

  Users? users;

  Future getUser() async {
    final userResult = await fireStoreHelper.getUserData(id);
    setState(() {
      users = userResult;
    });
  }

  late Future<List<Jobs>> _futureJobs;
  int? currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CompaniesJobsProvider>(context, listen: false)
        .getAllJobsObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(
                  Icons.list,
                  size: SizeConfig.scaleWidth(22),
                ),
                color: Color(0xff4C5175),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child:  InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ProfileInfo();
                }));
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(),
                elevation: 4,
                color: Color(0xffcbb523),
                child: SizedBox(
                  width: SizeConfig.scaleWidth(30),
                  height: SizeConfig.scaleHeight(30),
                  child: CircleAvatar(
                    backgroundImage:AssetImage("assets/images/withoutImagePerson.jpg"),
                    ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xfffafafa),
      body: Consumer<CompaniesJobsProvider>(
          builder: (context, companiesJobsProvider, _) {
            companiesJobsProvider.JobsList.sort(
                    (a, b) => b.current_time!.compareTo(a.current_time!));

            List<Jobs> newJobs = companiesJobsProvider.JobsList.length >= 2
                ? companiesJobsProvider.JobsList.sublist(0, 2)
                : companiesJobsProvider.JobsList;
            print("the job lis $companiesJobsProvider.JobsList");
            return companiesJobsProvider.JobsList.isEmpty
                ? Center(child: Text("Not available jobs"))
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.scaleHeight(5),
                    ),
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                        width: SizeConfig.scaleWidth(390),
                        height: SizeConfig.scaleHeight(158),
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/home.png',
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.scaleWidth(10),
                      top: SizeConfig.scaleWidth(10),
                    ),
                    child: TextStyleWidget('New Jobs:', Color(0xffcbb523),
                        SizeConfig.scaleTextFont(15), FontWeight.w500),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: newJobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      currentIndex = index;
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          margin: EdgeInsets.all(
                            SizeConfig.scaleWidth(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return JobDetailsScreen();
                              }));
                            },
                            child: Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      )),
                                  child: Image.asset(
                                    companiesJobsProvider
                                        .JobsList.isNotEmpty
                                        ? companiesJobsProvider
                                        .JobsList[index]
                                        .job_image ??
                                        ""
                                        : "No Image",
                                    fit: BoxFit.cover,
                                    width: SizeConfig.scaleWidth(96),
                                    height: SizeConfig.scaleHeight(105),
                                    color: Color(0xff4C5175).withOpacity(0.5),
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
                                                companiesJobsProvider
                                                    .JobsList.isNotEmpty
                                                    ? companiesJobsProvider
                                                    .JobsList[index]
                                                    .job_name??
                                                    ""
                                                    : "No Job Name",
                                                Color(0xff4C5175),
                                                SizeConfig.scaleTextFont(15),
                                                FontWeight.w500),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.apartment,
                                                  size: SizeConfig.scaleWidth(
                                                      15),
                                                  color: Color(0xffcbb523),
                                                ),
                                                TextStyleWidget(
                                                    companiesJobsProvider
                                                        .JobsList.isNotEmpty
                                                        ? companiesJobsProvider
                                                        .JobsList[index]
                                                        .company_name ??
                                                        ""
                                                        : "No Company Name",
                                                    Colors.black,
                                                    SizeConfig.scaleTextFont(
                                                        10),
                                                    FontWeight.w500),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
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
                                                      companiesJobsProvider
                                                          .JobsList
                                                          .isNotEmpty
                                                          ? companiesJobsProvider
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
                                                  ],
                                                ),
                                                TextStyleWidget(
                                                  companiesJobsProvider
                                                      .JobsList
                                                      .isNotEmpty
                                                      ? companiesJobsProvider
                                                      .JobsList[
                                                  index]
                                                      .current_time ??
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
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width:
                                              SizeConfig.scaleWidth(120),
                                              height:
                                              SizeConfig.scaleHeight(26),
                                              child: ElevatedButton(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .touch_app_outlined,
                                                      color:
                                                      Color(0xffcbb523),
                                                      size: SizeConfig
                                                          .scaleWidth(14),
                                                    ),
                                                    SizedBox(
                                                        width: SizeConfig
                                                            .scaleWidth(10)),
                                                    TextStyleWidget(
                                                        'Submition',
                                                        Colors.white,
                                                        SizeConfig
                                                            .scaleTextFont(
                                                            10),
                                                        FontWeight.w500),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                            return SubmitJopScreen();
                                                          }));
                                                },
                                                style:
                                                ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  Color(0xff4C5175),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              alignment:
                                              Alignment.centerRight,
                                              icon: Icon(
                                                Icons.favorite_border,
                                                size:
                                                SizeConfig.scaleWidth(20),
                                              ),
                                              color: Color(
                                                0xffcbb523,
                                              ),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
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
                        TextStyleWidget('All Jobs:', Color(0xffcbb523),
                            SizeConfig.scaleTextFont(15), FontWeight.w500),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return AllJobScreen();
                            }));
                          },
                          child: TextStyleWidget(
                              'see all',
                              Color(0xffCB3423),
                              SizeConfig.scaleTextFont(12),
                              FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: companiesJobsProvider.JobsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          margin: EdgeInsets.all(
                            SizeConfig.scaleWidth(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    )),
                                child: Image.asset(
                                  companiesJobsProvider
                                      .JobsList.isNotEmpty
                                      ? companiesJobsProvider
                                      .JobsList[index]
                                      .job_image ??
                                      ""
                                      : "No Image",
                                  fit: BoxFit.cover,
                                  width: SizeConfig.scaleWidth(96),
                                  height: SizeConfig.scaleHeight(105),
                                  color: Color(0xff4C5175).withOpacity(0.5),
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
                                              companiesJobsProvider
                                                  .JobsList.isNotEmpty
                                                  ? companiesJobsProvider
                                                  .JobsList[index]
                                                  .job_name ??
                                                  ""
                                                  : "No Job Name",
                                              Color(0xff4C5175),
                                              SizeConfig.scaleTextFont(15),
                                              FontWeight.w500),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.apartment,
                                                size:
                                                SizeConfig.scaleWidth(15),
                                                color: Color(0xffcbb523),
                                              ),
                                              TextStyleWidget(
                                                  companiesJobsProvider
                                                      .JobsList.isNotEmpty
                                                      ? companiesJobsProvider
                                                      .JobsList[index]
                                                      .company_name??
                                                      ""
                                                      : "No Company Name",
                                                  Colors.black,
                                                  SizeConfig.scaleTextFont(
                                                      10),
                                                  FontWeight.w500),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
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
                                                    companiesJobsProvider
                                                        .JobsList
                                                        .isNotEmpty
                                                        ? companiesJobsProvider
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
                                                ],
                                              ),
                                              TextStyleWidget(
                                                companiesJobsProvider
                                                    .JobsList
                                                    .isNotEmpty
                                                    ? companiesJobsProvider
                                                    .JobsList[
                                                index]
                                                    .current_time ??
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
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(120),
                                            height:
                                            SizeConfig.scaleHeight(26),
                                            child: ElevatedButton(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.touch_app_outlined,
                                                    color: Color(0xffcbb523),
                                                    size:
                                                    SizeConfig.scaleWidth(
                                                        14),
                                                  ),
                                                  SizedBox(
                                                      width: SizeConfig
                                                          .scaleWidth(10)),
                                                  TextStyleWidget(
                                                      'Submition',
                                                      Colors.white,
                                                      SizeConfig
                                                          .scaleTextFont(10),
                                                      FontWeight.w500),
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return SubmitJopScreen();
                                                        }));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Color(0xff4C5175),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            alignment: Alignment.centerRight,
                                            icon: Icon(
                                              Icons.favorite_border,
                                              size: SizeConfig.scaleWidth(20),
                                            ),
                                            color: Color(
                                              0xffcbb523,
                                            ),
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              ),

            );
          }
      ),
    );
  }
}
