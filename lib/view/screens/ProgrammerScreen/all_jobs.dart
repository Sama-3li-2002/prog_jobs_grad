import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/customWidget/ProfWidget.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/SubmitJopScreen.dart';
import 'package:provider/provider.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../../model/JobsModel.dart';
import '../../../providers/CompaniesJobsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'JobsDetails.dart';
import 'ProfileInfoScreen.dart';

class AllJobScreen extends StatefulWidget {
  static const String id = "all_jobs_screen";

  @override
  State<AllJobScreen> createState() => _AllJobScreenState();
}

class _AllJobScreenState extends State<AllJobScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CompaniesJobsProvider>(context, listen: false)
        .getAllJobsObjects();
  }

  String user_id = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper firestore_helper = FirebaseFireStoreHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(20),
          ),
          color: Color(0xff4C5175),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
          ),
          InkWell(
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
                child: ProfWidget(),
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
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                      child: TextStyleWidget('All Jobs:', Color(0xffcbb523),
                          SizeConfig.scaleTextFont(15), FontWeight.w500),
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
                            child: InkWell(
                              onTap: () async {
                                List<Company> comInfo = await getCompanyInfo(
                                    companiesJobsProvider.JobsList.elementAt(
                                            index)
                                        .id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return JobsDetails(
                                      items: [
                                        companiesJobsProvider.JobsList
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    )),
                                    child: Image.network(
                                      companiesJobsProvider.JobsList.isNotEmpty
                                          ? companiesJobsProvider
                                                  .JobsList[index].job_image ??
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
                                                    size: SizeConfig.scaleWidth(
                                                        15),
                                                    color: Color(0xffcbb523),
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
                                                            .scaleWidth(14),
                                                        color:
                                                            Color(0xffcbb523),
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig
                                                            .scaleWidth(3),
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
                                                            .scaleTextFont(10),
                                                        FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                  TextStyleWidget(
                                                    companiesJobsProvider
                                                            .JobsList.isNotEmpty
                                                        ? companiesJobsProvider
                                                                .JobsList[index]
                                                                .current_time ??
                                                            ""
                                                        : "No Current Time",
                                                    Colors.black,
                                                    SizeConfig.scaleTextFont(
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
                                                  onPressed: () async {
                                                    List<Company> comInfo =
                                                        await getCompanyInfo(
                                                            companiesJobsProvider
                                                                        .JobsList
                                                                    .elementAt(
                                                                        index)
                                                                .id);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return SubmitJopScreen(
                                                        itemsComInfo: comInfo,
                                                        ComId:
                                                            companiesJobsProvider
                                                                        .JobsList
                                                                    .elementAt(
                                                                        index)
                                                                .id,
                                                        JobId:
                                                            companiesJobsProvider
                                                                        .JobsList
                                                                    .elementAt(
                                                                        index)
                                                                .job_id,
                                                      );
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
                                                icon: FutureBuilder<bool>(
                                                  future: isFav(
                                                    companiesJobsProvider
                                                                .JobsList
                                                            .elementAt(index)
                                                        .job_id!,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      // Display a loading indicator while checking favorited status
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      print('Error');
                                                      return Icon(Icons
                                                          .favorite_border_outlined);
                                                    } else {
                                                      return Icon(
                                                        snapshot.data == true
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_outlined,
                                                        size: SizeConfig
                                                            .scaleWidth(20),
                                                      );
                                                    }
                                                  },
                                                ),
                                                color: Color(0xffcbb523),
                                                onPressed: () async {
                                                  bool isJobFavorited =
                                                      await isFav(
                                                          companiesJobsProvider
                                                                      .JobsList
                                                                  .elementAt(
                                                                      index)
                                                              .job_id!);

                                                  if (isJobFavorited) {
                                                    await firestore_helper
                                                        .removeFromFavorites(
                                                            user_id,
                                                            companiesJobsProvider
                                                                        .JobsList
                                                                    .elementAt(
                                                                        index)
                                                                .job_id!);
                                                  } else {
                                                    await firestore_helper
                                                        .addToFavorites(
                                                            user_id,
                                                            companiesJobsProvider
                                                                        .JobsList
                                                                    .elementAt(
                                                                        index)
                                                                .job_id!);
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
                            ));
                      },
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Future<List<Company>> getCompanyInfo(String? id) async {
    List<Company> comInfoList =
        await FirebaseFireStoreHelper.instance.getComInfoById(id!);

    return comInfoList;
  }

  Future<bool> isFav(job_id) {
    return firestore_helper.isJobFavorited(user_id, job_id);
  }
}
