import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/view/customWidget/ProfWidget.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/SubmitJopScreen.dart';
import 'package:provider/provider.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
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

  // For search icon
  TextEditingController _searchController = TextEditingController();
  List<Jobs> _filteredJobs = [];
  late List<Jobs> allJobsList;

  @override
  void initState() {
    super.initState();

    //for provider
    allJobsList =
        Provider.of<CompaniesJobsProvider>(context, listen: false).JobsList;

    // For search icon
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  // For search
  void _performSearch() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      _filteredJobs = allJobsList.where((job) {
        return job.job_name!.toLowerCase().contains(query);
      }).toList();
    });
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
          // IconButton(
          //   icon: Icon(Icons.search,color: Colors.grey,),
          //   onPressed: () {
          //     setState(() {
          //       _searchController.clear();
          //       _filteredJobs.clear();
          //     });
          //   },
          // ),
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
        title: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: TextField(
            controller: _searchController,
            onChanged: (query) {
              _performSearch();
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.grey[200],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size
              color: Colors.black, // Text color
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xfffafafa),
      body: Consumer<CompaniesJobsProvider>(
          builder: (context, companiesJobsProvider, _) {
        allJobsList.sort((a, b) => b.current_time!.compareTo(a.current_time!));

        return allJobsList.isEmpty
            ? Center(child: Text("No available jobs"))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                      child: TextStyleWidget('All Jobs:', Color(0xffcbb523),
                          SizeConfig.scaleTextFont(15), FontWeight.w500),
                    ),
                    if (_searchController.text.isEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: allJobsList.length,
                        itemBuilder: (BuildContext context, int index) {

                          // لازالة الثواني من الوقت
                          late String formattedTime;
                          String timeString = allJobsList[index].current_time ?? "";
                          try {
                            formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          List<Company> comInfo =
                                              await getCompanyInfo(allJobsList
                                                  .elementAt(index)
                                                  .id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return JobsDetails(
                                                items: [
                                                  allJobsList.elementAt(index),
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
                                                  SizeConfig.scaleHeight(130),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
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
                                                    SizeConfig.scaleHeight(105),
                                                color: Color(0xff4C5175)
                                                    .withOpacity(0.5),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        TextStyleWidget(
                                                            allJobsList
                                                                    .isNotEmpty
                                                                ? allJobsList[
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
                                                                allJobsList
                                                                        .isNotEmpty
                                                                    ? allJobsList[index]
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
                                                                    allJobsList
                                                                            .isNotEmpty
                                                                        ? allJobsList[index].current_date ??
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
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 15),
                                                                child: TextStyleWidget(
                                                                  allJobsList
                                                                          .isNotEmpty
                                                                      ?formattedTime ??
                                                                          ""
                                                                      : "No Current Time",
                                                                  Colors.black,
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight.w500,
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
                                                              .scaleWidth(120),
                                                          height: SizeConfig
                                                              .scaleHeight(26),
                                                          child: ElevatedButton(
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
                                                                      allJobsList
                                                                          .elementAt(
                                                                              index)
                                                                          .id);
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return SubmitJopScreen(
                                                                  itemsComInfo:
                                                                      comInfo,
                                                                  ComId: allJobsList
                                                                      .elementAt(
                                                                          index)
                                                                      .id,
                                                                  JobId: allJobsList
                                                                      .elementAt(
                                                                          index)
                                                                      .job_id,
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
                                                              allJobsList
                                                                  .elementAt(
                                                                      index)
                                                                  .job_id!,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                print('Error');
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
                                                          color:
                                                              Color(0xffcbb523),
                                                          onPressed: () async {
                                                            bool
                                                                isJobFavorited =
                                                                await isFav(allJobsList
                                                                    .elementAt(
                                                                        index)
                                                                    .job_id!);

                                                            if (isJobFavorited) {
                                                              await firestore_helper
                                                                  .removeFromFavorites(
                                                                      user_id,
                                                                      allJobsList
                                                                          .elementAt(
                                                                              index)
                                                                          .job_id!);
                                                            } else {
                                                              await firestore_helper
                                                                  .addToFavorites(
                                                                      user_id,
                                                                      allJobsList
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
                                      ))));
                        },
                      ),
                    if (_searchController.text.isNotEmpty&& _filteredJobs.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredJobs.length,
                        itemBuilder: (BuildContext context, int index) {
                          // لازالة الثواني من الوقت
                          late String formattedTime;
                          String timeString = _filteredJobs[index].current_time ?? "";
                          try {
                            formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          List<Company> comInfo =
                                              await getCompanyInfo(_filteredJobs
                                                  .elementAt(index)
                                                  .id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return JobsDetails(
                                                items: [
                                                  _filteredJobs
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
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
                                                    SizeConfig.scaleHeight(105),
                                                color: Color(0xff4C5175)
                                                    .withOpacity(0.5),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        TextStyleWidget(
                                                            _filteredJobs
                                                                    .isNotEmpty
                                                                ? _filteredJobs[
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
                                                                _filteredJobs
                                                                        .isNotEmpty
                                                                    ? _filteredJobs
                                                                            .elementAt(
                                                                                index)
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
                                                                    _filteredJobs
                                                                            .isNotEmpty
                                                                        ? _filteredJobs[index].current_date ??
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
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 15),
                                                                child: TextStyleWidget(
                                                                  _filteredJobs
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
                                                              .scaleWidth(120),
                                                          height: SizeConfig
                                                              .scaleHeight(26),
                                                          child: ElevatedButton(
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
                                                                      _filteredJobs
                                                                          .elementAt(
                                                                              index)
                                                                          .id);
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return SubmitJopScreen(
                                                                  itemsComInfo:
                                                                      comInfo,
                                                                  ComId: _filteredJobs
                                                                      .elementAt(
                                                                          index)
                                                                      .id,
                                                                  JobId: _filteredJobs
                                                                      .elementAt(
                                                                          index)
                                                                      .job_id,
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
                                                              _filteredJobs
                                                                  .elementAt(
                                                                      index)
                                                                  .job_id!,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                print('Error');
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
                                                          color:
                                                              Color(0xffcbb523),
                                                          onPressed: () async {
                                                            bool
                                                                isJobFavorited =
                                                                await isFav(
                                                                    _filteredJobs
                                                                        .elementAt(
                                                                            index)
                                                                        .job_id!);

                                                            if (isJobFavorited) {
                                                              await firestore_helper.removeFromFavorites(
                                                                  user_id,
                                                                  _filteredJobs
                                                                      .elementAt(
                                                                          index)
                                                                      .job_id!);
                                                            } else {
                                                              await firestore_helper.addToFavorites(
                                                                  user_id,
                                                                  _filteredJobs
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
                                      ))));
                        },
                      ),
                    if (_searchController.text.isNotEmpty && _filteredJobs.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "No search result",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 18.0, // Increase the font size
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              );
      },

      ),
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
