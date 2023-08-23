import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AddNewJobScreen.dart';
import 'package:provider/provider.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/JobsModel.dart';
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
  //For Icon
  List<bool> isPressedList = [];
  @override
  void initState() {
    super.initState();
    Provider.of<CompanyJobsProvider>(context, listen: false)
        .getAllJobsObjects();
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
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
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
      backgroundColor: Color(0xfffafafa),
      body: SingleChildScrollView(
        child: Consumer<CompanyJobsProvider>(
          builder: (context, companyJobsProvider, _) => companyJobsProvider
                  .JobsList.isEmpty
              ? Center(child: Text("Not available jobs"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                      child: TextStyleWidget(
                        'All Jobs:',
                        Color(0xffcbb523),
                        SizeConfig.scaleTextFont(15),
                        FontWeight.w500,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: companyJobsProvider.JobsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (isPressedList.length <= index) {
                          isPressedList.add(false);
                        }
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return JobsCompanyDetailsScreen(items: [
                                    companyJobsProvider.JobsList
                                        .elementAt(index),
                                  ]);
                                }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Card (
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
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
                                          companyJobsProvider.JobsList.isNotEmpty
                                              ? companyJobsProvider
                                                      .JobsList[index].job_image ??
                                                  ""
                                              : "No Image",
                                          fit: BoxFit.cover,
                                          width: SizeConfig.scaleWidth(96),
                                          height: SizeConfig.scaleHeight(115),
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
                                                    companyJobsProvider
                                                            .JobsList.isNotEmpty
                                                        ? companyJobsProvider
                                                                .JobsList[index]
                                                                .job_name ??
                                                            ""
                                                        : "No Job Name",
                                                    Color(0xff4C5175),
                                                    SizeConfig.scaleTextFont(15),
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
                                                        size:
                                                            SizeConfig.scaleWidth(15),
                                                        color: Color(0xffcbb523),
                                                      ),
                                                      TextStyleWidget(
                                                        companyJobsProvider
                                                                .JobsList.isNotEmpty
                                                            ? companyJobsProvider
                                                                    .JobsList[index]
                                                                    .company_name ??
                                                                ""
                                                            : "No Company Name",
                                                        Colors.black,
                                                        SizeConfig.scaleTextFont(10),
                                                        FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 8),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.access_time,
                                                              size:
                                                                  SizeConfig.scaleWidth(
                                                                      14),
                                                              color: Color(0xffcbb523),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  SizeConfig.scaleWidth(
                                                                      3),
                                                            ),
                                                            TextStyleWidget(
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
                                                              SizeConfig.scaleTextFont(
                                                                  10),
                                                              FontWeight.w500,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      TextStyleWidget(
                                                        companyJobsProvider
                                                                .JobsList.isNotEmpty
                                                            ? companyJobsProvider
                                                                    .JobsList[index]
                                                                    .current_time ??
                                                                ""
                                                            : "No Current Time",
                                                        Colors.black,
                                                        SizeConfig.scaleTextFont(10),
                                                        FontWeight.w500,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig.scaleWidth(145),
                                                    height:
                                                        SizeConfig.scaleHeight(30),
                                                    child: ElevatedButton(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: SizeConfig
                                                                .scaleHeight(18),
                                                            width:
                                                                SizeConfig.scaleWidth(
                                                                    18),
                                                            child: Text(
                                                              '12',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins',
                                                                backgroundColor:
                                                                    Color(0xffcbb523),
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                fontSize: SizeConfig
                                                                    .scaleTextFont(
                                                                        10),
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          TextStyleWidget(
                                                            'number of requests',
                                                            Colors.white,
                                                            SizeConfig.scaleTextFont(
                                                                10),
                                                            FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) {
                                                          return NumberOfRequestsScreen();
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
                                                    alignment:
                                                    Alignment.centerRight,
                                                    icon: isPressedList[index]
                                                        ? Icon(Icons.bookmark,color:Color(0xffcbb523),)
                                                        : Icon(Icons.bookmark_border,color:Color(0xffcbb523)),
                                                    onPressed: ()async {
                                                      setState(() {
                                                        isPressedList[index] = !isPressedList[index];
                                                      });
                                                      // await archiveJobs(companyJobsProvider.JobsList
                                                      //     .elementAt(index));
                                                      delete(companyJobsProvider.JobsList
                                                          .elementAt(index).job_id!);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
  Future<void> archiveJobs(Jobs jobs) async {

    DocumentReference documentReference = await FirebaseFireStoreHelper.instance.createArchiveJob(jobs);
    String newJobId = documentReference.id;

  }

  void delete (String jobId){
    FirebaseFireStoreHelper.instance.deleteDocument(jobId);
  }
}
