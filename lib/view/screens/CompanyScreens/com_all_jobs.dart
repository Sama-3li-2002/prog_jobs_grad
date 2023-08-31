import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/CompanyModel.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AddNewJobScreen.dart';
import 'package:provider/provider.dart';
import '../../../providers/CompanyJobsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'JobsCompanyDetailsScreen.dart';
import 'no_of_request.dart';

class ComAllJobScreen extends StatefulWidget {
  static const String id = "com_all_jobs_screen";

  @override
  State<ComAllJobScreen> createState() => _ComAllJobScreenState();
}

class _ComAllJobScreenState extends State<ComAllJobScreen> {
  //For archive Icon
  List<bool> isPressedList = [];

  // For search icon
  TextEditingController _searchController = TextEditingController();
  List<Jobs> _filteredJobs = [];
  late List<Jobs> allJobsList;

  //for provider
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    allJobsList =
        Provider.of<CompanyJobsProvider>(context, listen: false).JobsList;

    setState(() {
      isDataLoaded = true;
    });

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
      body: Consumer<CompanyJobsProvider>(
          builder: (context, companyJobsProvider, _) {
        allJobsList.sort((a, b) => b.current_time!.compareTo(a.current_time!));
        return companyJobsProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : (companyJobsProvider.JobsList.isEmpty)
                ? Center(
                    child: Text(
                      'No available job',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.scaleWidth(10),
                              top: SizeConfig.scaleHeight(20)),
                          child: TextStyleWidget(
                            'All Jobs:',
                            Color(0xffcbb523),
                            SizeConfig.scaleTextFont(15),
                            FontWeight.w500,
                          ),
                        ),
                        if (_searchController.text.isEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allJobsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // لازالة الثواني من الوقت
                              late String formattedTime;
                              String timeString =
                                  allJobsList[index].current_time ?? "";
                              try {
                                formattedTime = DateFormat('hh:mm a').format(
                                    DateFormat('hh:mm:ss a').parse(timeString));
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                        allJobsList
                                                            .elementAt(index),
                                                      ]),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height:
                                                      SizeConfig.scaleHeight(
                                                          110),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  )),
                                                  child: Image.network(
                                                    allJobsList[index]
                                                        .job_image!,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        SizeConfig.scaleWidth(
                                                            96),
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
                                                      left:
                                                          SizeConfig.scaleWidth(
                                                              10),
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
                                                              FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .apartment,
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
                                                                      .w500,
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .access_time,
                                                                        size: SizeConfig.scaleWidth(
                                                                            14),
                                                                        color: Color(
                                                                            0xffcbb523),
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .scaleWidth(3),
                                                                      ),
                                                                      TextStyleWidget(

                                                                        allJobsList
                                                                            .isNotEmpty
                                                                            ? formattedTime ??
                                                                            ""
                                                                            : "No Current Time",


                                                                        Colors
                                                                            .black,
                                                                        SizeConfig.scaleTextFont(
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
                                                                                20),
                                                                    child:
                                                                        TextStyleWidget(
                                                                          allJobsList.isNotEmpty
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
                                                                  .scaleHeight(
                                                                      30),
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    TextStyleWidget(
                                                                  'number of requests',
                                                                  Colors.white,
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return NumberOfRequestsScreen(
                                                                      jobs: allJobsList[
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
                                                                            .circular(2),
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
                                                                      Icons
                                                                          .bookmark,
                                                                      color: Color(
                                                                          0xffcbb523),
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .bookmark_border,
                                                                      color: Color(
                                                                          0xffcbb523)),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  isPressedList[
                                                                          index] =
                                                                      !isPressedList[
                                                                          index];
                                                                });
                                                                await archiveJobs(
                                                                    allJobsList
                                                                        .elementAt(
                                                                            index));
                                                                delete(allJobsList
                                                                    .elementAt(
                                                                        index)
                                                                    .job_id!);
                                                                setState(() {
                                                                  allJobsList
                                                                      .removeAt(
                                                                          index);
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
                        if (_searchController.text.isNotEmpty &&
                            _filteredJobs.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _filteredJobs.length,
                            itemBuilder: (BuildContext context, int index) {
                              // لازالة الثواني من الوقت
                              late String formattedTime;
                              String timeString =
                                  allJobsList[index].current_time ?? "";
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return JobsCompanyDetailsScreen(
                                                    items: [
                                                      _filteredJobs
                                                          .elementAt(index),
                                                    ],
                                                  );
                                                }),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height:
                                                      SizeConfig.scaleHeight(
                                                          110),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  )),
                                                  child: Image.network(
                                                    allJobsList[index]
                                                        .job_image!,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        SizeConfig.scaleWidth(
                                                            96),
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
                                                      left:
                                                          SizeConfig.scaleWidth(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            TextStyleWidget(
                                                                _filteredJobs
                                                                        .isNotEmpty
                                                                    ? _filteredJobs[index]
                                                                            .job_name ??
                                                                        ""
                                                                    : "No Job Name",
                                                                Color(
                                                                    0xff4C5175),
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                        15),
                                                                FontWeight
                                                                    .w500),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .apartment,
                                                                  size: SizeConfig
                                                                      .scaleWidth(
                                                                          15),
                                                                  color: Color(
                                                                      0xffcbb523),
                                                                ),
                                                                TextStyleWidget(
                                                                    _filteredJobs
                                                                            .isNotEmpty
                                                                        ? _filteredJobs.elementAt(index).company_name ??
                                                                            ""
                                                                        : "No Company Name",
                                                                    Colors
                                                                        .black,
                                                                    SizeConfig
                                                                        .scaleTextFont(
                                                                            10),
                                                                    FontWeight
                                                                        .w500),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .access_time,
                                                                        size: SizeConfig.scaleWidth(
                                                                            14),
                                                                        color: Color(
                                                                            0xffcbb523),
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .scaleWidth(3),
                                                                      ),
                                                                      TextStyleWidget(
                                                                        _filteredJobs
                                                                            .isNotEmpty
                                                                            ? formattedTime ??
                                                                            ""
                                                                            : "No Current Time",

                                                                        Colors
                                                                            .black,
                                                                        SizeConfig.scaleTextFont(
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
                                                                                20),
                                                                    child:
                                                                        TextStyleWidget(
                                                                          _filteredJobs.isNotEmpty
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
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              height: SizeConfig
                                                                  .scaleHeight(
                                                                      30),
                                                              child:
                                                                  ElevatedButton(
                                                                child:
                                                                    TextStyleWidget(
                                                                  'number of requests',
                                                                  Colors.white,
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return NumberOfRequestsScreen(
                                                                      jobs: _filteredJobs[
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
                                                                            .circular(2),
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
                                                                      Icons
                                                                          .bookmark,
                                                                      color: Color(
                                                                          0xffcbb523),
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .bookmark_border,
                                                                      color: Color(
                                                                          0xffcbb523)),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  isPressedList[
                                                                          index] =
                                                                      !isPressedList[
                                                                          index];
                                                                });
                                                                await archiveJobs(
                                                                    _filteredJobs
                                                                        .elementAt(
                                                                            index));
                                                                delete(_filteredJobs
                                                                    .elementAt(
                                                                        index)
                                                                    .job_id!);
                                                                setState(() {
                                                                  _filteredJobs
                                                                      .removeAt(
                                                                          index);
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
                        if (_searchController.text.isNotEmpty &&
                            _filteredJobs.isEmpty)
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
      }),
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
