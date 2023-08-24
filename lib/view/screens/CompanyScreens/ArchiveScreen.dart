import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/providers/ArchiveProvider.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../customWidget/textStyleWidget.dart';
import 'JobsCompanyDetailsScreen.dart';
import 'no_of_request.dart';

class Archive extends StatefulWidget {
  static const String id = "archive_screen";

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ArchiveProvider>(context, listen: false).getArchiveJobsObjects();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
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
        ],
        elevation: 0,
      ),
      body:Consumer<ArchiveProvider>(
        builder: (context, archiveProvider, _) => archiveProvider.archiveList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                child: TextStyleWidget(
                  'All Archives',
                  Color(0xffcbb523),
                  SizeConfig.scaleTextFont(15),
                  FontWeight.w500,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:archiveProvider.archiveList.length ,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return JobsCompanyDetailsScreen(items: [
                              archiveProvider.archiveList
                                  .elementAt(index),
                            ]);
                          }));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),

                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            // margin: EdgeInsets.all(
                            //   SizeConfig.scaleWidth(15),
                            // ),
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
                                    'assets/images/computer.png',
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
                                              archiveProvider
                                                  .archiveList
                                                  .isNotEmpty
                                                  ? archiveProvider
                                                  .archiveList[index]
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
                                                  size: SizeConfig.scaleWidth(15),
                                                  color: Color(0xffcbb523),
                                                ),
                                                TextStyleWidget(
                                                  archiveProvider
                                                      .archiveList
                                                      .isNotEmpty
                                                      ? archiveProvider
                                                      .archiveList[index]
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
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [

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
                                                            archiveProvider
                                                                .archiveList
                                                                .isNotEmpty
                                                                ? archiveProvider
                                                                .archiveList[index]
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
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 16,),
                                                          TextStyleWidget(
                                                            archiveProvider
                                                                .archiveList
                                                                .isNotEmpty
                                                                ? archiveProvider
                                                                .archiveList[index]
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
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(145),
                                              height: SizeConfig.scaleHeight(30),
                                              child: ElevatedButton(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                      SizeConfig.scaleHeight(18),
                                                      width: SizeConfig.scaleWidth(18),
                                                      child: Text(
                                                        '12',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          backgroundColor:
                                                          Color(0xffcbb523),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize:
                                                          SizeConfig.scaleTextFont(
                                                              10),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    TextStyleWidget(
                                                      'number of requests',
                                                      Colors.white,
                                                      SizeConfig.scaleTextFont(10),
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
                                                  backgroundColor: Color(0xff4C5175),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),

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
        ),),
    );
  }
}