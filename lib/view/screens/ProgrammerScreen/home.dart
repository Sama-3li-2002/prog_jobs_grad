import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ShowMessagesCom.dart';
import 'package:provider/provider.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../../model/JobsModel.dart';
import '../../../notification_service.dart';
import '../../../providers/CompaniesJobsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/DrawerWidget.dart';
import '../../customWidget/ProfWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'JobsDetails.dart';
import 'SubmitJopScreen.dart';
import 'all_jobs.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? currentIndex;
  String user_id = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper firestore_helper = FirebaseFireStoreHelper.instance;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    Provider.of<CompaniesJobsProvider>(context, listen: false)
        .getAllJobsObjects();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (context) => IconButton(
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
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProfileInfo(
                      FirebaseAuthController.fireAuthHelper.userId());
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
                  child: ProfWidget(),
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

        print("the job list $companiesJobsProvider.JobsList");
        return companiesJobsProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : companiesJobsProvider.JobsList.isEmpty
                ? Column(
                    children: [
                      Image(
                          width: SizeConfig.scaleWidth(390),
                          height: SizeConfig.scaleHeight(158),
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/home.png',
                          )),
                      Center(child: Text("Not available jobs")),
                    ],
                  )
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
                            // لازالة الثواني من الوقت
                            late String formattedTime;
                            String timeString =
                                newJobs[index].current_time ?? "";
                            try {
                              formattedTime = DateFormat('hh:mm a').format(
                                  DateFormat('hh:mm:ss a').parse(timeString));
                            } catch (e) {
                              print("Invalid data format: $timeString");
                              formattedTime = "Invalid time format";
                            }

                            currentIndex = index;
                            return Container(
                                margin: EdgeInsets.all(
                                  SizeConfig.scaleWidth(15),
                                ),
                                child: Material(
                                    elevation: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            List<Company> comInfo =
                                                await getCompanyInfo(
                                                    companiesJobsProvider
                                                                .JobsList
                                                            .elementAt(index)
                                                        .id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return JobsDetails(
                                                  items: [
                                                    companiesJobsProvider
                                                            .JobsList
                                                        .elementAt(index),
                                                  ],
                                                  itemsComInfo: comInfo,
                                                );
                                              }),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                height:
                                                    SizeConfig.scaleHeight(120),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                )),
                                                child: Image.network(
                                                  newJobs.isNotEmpty
                                                      ? newJobs[index]
                                                              .job_image ??
                                                          ""
                                                      : "No Image",
                                                  fit: BoxFit.cover,
                                                  width:
                                                      SizeConfig.scaleWidth(96),
                                                  height:
                                                      SizeConfig.scaleHeight(
                                                          90),
                                                  color: Color(0xff4C5175)
                                                      .withOpacity(0.5),
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig.scaleWidth(
                                                        10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          TextStyleWidget(
                                                              newJobs.isNotEmpty
                                                                  ? newJobs[index]
                                                                          .job_name ??
                                                                      ""
                                                                  : "No Job Name",
                                                              Color(0xff4C5175),
                                                              SizeConfig
                                                                  .scaleTextFont(
                                                                      15),
                                                              FontWeight.w500),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.apartment,
                                                                size: SizeConfig
                                                                    .scaleWidth(
                                                                        15),
                                                                color: Color(
                                                                    0xffcbb523),
                                                              ),
                                                              TextStyleWidget(
                                                                  newJobs.isNotEmpty
                                                                      ? newJobs[index]
                                                                              .company_name ??
                                                                          ""
                                                                      : "No Company Name",
                                                                  Colors.black,
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight
                                                                      .w500),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8.0),
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
                                                                      newJobs.isNotEmpty
                                                                          ? formattedTime ??
                                                                              ""
                                                                          : "No Current Time",
                                                                      Colors
                                                                          .black,
                                                                      SizeConfig
                                                                          .scaleTextFont(
                                                                              10),
                                                                      FontWeight
                                                                          .w500,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15),
                                                                  child:
                                                                      TextStyleWidget(
                                                                    newJobs.isNotEmpty
                                                                        ? newJobs[index].current_date ??
                                                                            ""
                                                                        : "No Current Date",
                                                                    Colors
                                                                        .black,
                                                                    SizeConfig
                                                                        .scaleTextFont(
                                                                            10),
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: SizeConfig
                                                                .scaleWidth(
                                                                    120),
                                                            height: SizeConfig
                                                                .scaleHeight(
                                                                    26),
                                                            child:
                                                                ElevatedButton(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .touch_app_outlined,
                                                                    color: Color(
                                                                        0xffcbb523),
                                                                    size: SizeConfig
                                                                        .scaleWidth(
                                                                            14),
                                                                  ),
                                                                  SizedBox(
                                                                      width: SizeConfig
                                                                          .scaleWidth(
                                                                              10)),
                                                                  TextStyleWidget(
                                                                      'Submition',
                                                                      Colors
                                                                          .white,
                                                                      SizeConfig
                                                                          .scaleTextFont(
                                                                              10),
                                                                      FontWeight
                                                                          .w500),
                                                                ],
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                List<Company>
                                                                    comInfo =
                                                                    await getCompanyInfo(
                                                                        companiesJobsProvider.JobsList.elementAt(index)
                                                                            .id);

                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return SubmitJopScreen(
                                                                    itemsComInfo:
                                                                        comInfo,
                                                                    ComId: companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .id!,
                                                                    JobId: companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .job_id!,
                                                                  );
                                                                }));
                                                              },
                                                              style:
                                                                  ElevatedButton
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
                                                            icon: FutureBuilder<
                                                                bool>(
                                                              future: isFav(
                                                                companiesJobsProvider
                                                                            .JobsList
                                                                        .elementAt(
                                                                            index)
                                                                    .job_id!,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  print(
                                                                      'Error');
                                                                  return Icon(Icons
                                                                      .favorite_border_outlined);
                                                                } else {
                                                                  return Icon(
                                                                    snapshot.data ==
                                                                            true
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_border_outlined,
                                                                    size: SizeConfig
                                                                        .scaleWidth(
                                                                            20),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                            color: Color(
                                                                0xffcbb523),
                                                            onPressed:
                                                                () async {
                                                              bool
                                                                  isJobFavorited =
                                                                  await isFav(companiesJobsProvider
                                                                              .JobsList
                                                                          .elementAt(
                                                                              index)
                                                                      .job_id!);

                                                              if (isJobFavorited) {
                                                                await firestore_helper
                                                                    .removeFromFavorites(
                                                                        user_id,
                                                                        companiesJobsProvider.JobsList.elementAt(index)
                                                                            .job_id!);
                                                              } else {
                                                                await firestore_helper.addToFavorites(
                                                                    user_id,
                                                                    companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .job_id!,
                                                                    companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .id!);
                                                              }

                                                              setState(() {
                                                                isJobFavorited =
                                                                    !isJobFavorited;
                                                              });
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
                                  FontWeight.w500),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
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
                            // لازالة الثواني من الوقت
                            late String formattedTime;
                            String timeString = companiesJobsProvider
                                    .JobsList[index].current_time ??
                                "";
                            try {
                              formattedTime = DateFormat('hh:mm a').format(
                                  DateFormat('hh:mm:ss a').parse(timeString));
                            } catch (e) {
                              print("Invalid data format: $timeString");
                              formattedTime = "Invalid time format";
                            }

                            return Container(
                                margin: EdgeInsets.all(
                                  SizeConfig.scaleWidth(15),
                                ),
                                child: Material(
                                    elevation: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            List<Company> comInfo =
                                                await getCompanyInfo(
                                                    companiesJobsProvider
                                                                .JobsList
                                                            .elementAt(index)
                                                        .id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return JobsDetails(
                                                  items: [
                                                    companiesJobsProvider
                                                            .JobsList
                                                        .elementAt(index),
                                                  ],
                                                  itemsComInfo: comInfo,
                                                );
                                              }),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height:
                                                    SizeConfig.scaleHeight(120),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                )),
                                                child: Image.network(
                                                  companiesJobsProvider
                                                          .JobsList.isNotEmpty
                                                      ? companiesJobsProvider
                                                              .JobsList[index]
                                                              .job_image ??
                                                          ""
                                                      : "No Image",
                                                  fit: BoxFit.cover,
                                                  width:
                                                      SizeConfig.scaleWidth(96),
                                                  height:
                                                      SizeConfig.scaleHeight(
                                                          105),
                                                  color: Color(0xff4C5175)
                                                      .withOpacity(0.5),
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: SizeConfig.scaleWidth(
                                                        10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          TextStyleWidget(
                                                              companiesJobsProvider
                                                                      .JobsList
                                                                      .isNotEmpty
                                                                  ? companiesJobsProvider
                                                                          .JobsList[
                                                                              index]
                                                                          .job_name ??
                                                                      ""
                                                                  : "No Job Name",
                                                              Color(0xff4C5175),
                                                              SizeConfig
                                                                  .scaleTextFont(
                                                                      15),
                                                              FontWeight.w500),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.apartment,
                                                                size: SizeConfig
                                                                    .scaleWidth(
                                                                        15),
                                                                color: Color(
                                                                    0xffcbb523),
                                                              ),
                                                              TextStyleWidget(
                                                                  companiesJobsProvider
                                                                          .JobsList
                                                                          .isNotEmpty
                                                                      ? companiesJobsProvider
                                                                              .JobsList[
                                                                                  index]
                                                                              .company_name ??
                                                                          ""
                                                                      : "No Company Name",
                                                                  Colors.black,
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight
                                                                      .w500),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8.0),
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
                                                                      companiesJobsProvider
                                                                              .JobsList
                                                                              .isNotEmpty
                                                                          ? formattedTime ??
                                                                              ""
                                                                          : "No Current Time",
                                                                      Colors
                                                                          .black,
                                                                      SizeConfig
                                                                          .scaleTextFont(
                                                                              10),
                                                                      FontWeight
                                                                          .w500,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15),
                                                                  child:
                                                                      TextStyleWidget(
                                                                    companiesJobsProvider
                                                                            .JobsList
                                                                            .isNotEmpty
                                                                        ? companiesJobsProvider.JobsList[index].current_date ??
                                                                            ""
                                                                        : "No Current Date",
                                                                    Colors
                                                                        .black,
                                                                    SizeConfig
                                                                        .scaleTextFont(
                                                                            10),
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: SizeConfig
                                                                .scaleWidth(
                                                                    120),
                                                            height: SizeConfig
                                                                .scaleHeight(
                                                                    26),
                                                            child:
                                                                ElevatedButton(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .touch_app_outlined,
                                                                    color: Color(
                                                                        0xffcbb523),
                                                                    size: SizeConfig
                                                                        .scaleWidth(
                                                                            14),
                                                                  ),
                                                                  SizedBox(
                                                                      width: SizeConfig
                                                                          .scaleWidth(
                                                                              10)),
                                                                  TextStyleWidget(
                                                                      'Submition',
                                                                      Colors
                                                                          .white,
                                                                      SizeConfig
                                                                          .scaleTextFont(
                                                                              10),
                                                                      FontWeight
                                                                          .w500),
                                                                ],
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                List<Company>
                                                                    comInfo =
                                                                    await getCompanyInfo(
                                                                        companiesJobsProvider.JobsList.elementAt(index)
                                                                            .id);

                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return SubmitJopScreen(
                                                                    itemsComInfo:
                                                                        comInfo,
                                                                    ComId: companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .id!,
                                                                    JobId: companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .job_id!,
                                                                  );
                                                                }));
                                                              },
                                                              style:
                                                                  ElevatedButton
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
                                                            icon: FutureBuilder<
                                                                bool>(
                                                              future: isFav(
                                                                companiesJobsProvider
                                                                            .JobsList
                                                                        .elementAt(
                                                                            index)
                                                                    .job_id!,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  print(
                                                                      'Error');
                                                                  return Icon(Icons
                                                                      .favorite_border_outlined);
                                                                } else {
                                                                  return Icon(
                                                                    snapshot.data ==
                                                                            true
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_border_outlined,
                                                                    size: SizeConfig
                                                                        .scaleWidth(
                                                                            20),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                            color: Color(
                                                                0xffcbb523),
                                                            onPressed:
                                                                () async {
                                                              bool
                                                                  isJobFavorited =
                                                                  await isFav(companiesJobsProvider
                                                                              .JobsList
                                                                          .elementAt(
                                                                              index)
                                                                      .job_id!);

                                                              if (isJobFavorited) {
                                                                await firestore_helper
                                                                    .removeFromFavorites(
                                                                        user_id,
                                                                        companiesJobsProvider.JobsList.elementAt(index)
                                                                            .job_id!);
                                                              } else {
                                                                await firestore_helper.addToFavorites(
                                                                    user_id,
                                                                    companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .job_id!,
                                                                    companiesJobsProvider.JobsList.elementAt(
                                                                            index)
                                                                        .id!);
                                                              }

                                                              setState(() {
                                                                isJobFavorited =
                                                                    !isJobFavorited;
                                                              });
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
      }),
    );
  }

  Future<List<Company>> getCompanyInfo(String? id) async {
    List<Company> comInfoList = await firestore_helper.getComInfoById(id!);
    return comInfoList;
  }

  Future<bool> isFav(job_id) {
    return firestore_helper.isJobFavorited(user_id, job_id);
  }
}
