import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/providers/RequestStatusProvider.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:provider/provider.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../model/JobsModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/ProfWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class RequestStatusScreen extends StatefulWidget {
  static const String id = "request_status_screen";

  Jobs jobs = Jobs.main();

  @override
  State<RequestStatusScreen> createState() => _RequestStatusScreenState();
}

class _RequestStatusScreenState extends State<RequestStatusScreen> {
  String user_id = FirebaseAuthController.fireAuthHelper.userId();

  @override
  void initState() {
    super.initState();
    Provider.of<RequestStatusProvider>(context, listen: false)
        .getSubmittedJobsForUser(user_id);
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
      body: Consumer<RequestStatusProvider>(
          builder: (context, requestStatusProvider, _) {
        return requestStatusProvider.submittedJobs.isEmpty
            ? Center(child: Text("You didn't submit any request yet"))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                      child: TextStyleWidget(
                          'Requests Status:',
                          Color(0xffcbb523),
                          SizeConfig.scaleTextFont(15),
                          FontWeight.w500),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: requestStatusProvider.submittedJobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder<Jobs>(
                          future: requestStatusProvider.getJobInfo(
                              requestStatusProvider.submittedJobs[index].JobId!,
                              requestStatusProvider
                                  .submittedJobs[index].ComId!),
                          builder: (context, snapshot) {
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
                                    child: Image.network(
                                      snapshot.data!.job_image!,
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
                                          SizedBox(
                                            width: SizeConfig.screenWidth,
                                            child: TextStyleWidget(
                                                snapshot.data!.job_name!,
                                                Color(0xff4C5175),
                                                SizeConfig.scaleTextFont(15),
                                                FontWeight.w500),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    SizeConfig.scaleHeight(10),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.apartment,
                                                    size: SizeConfig.scaleWidth(
                                                        15),
                                                    color: Color(0xffcbb523),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.scaleWidth(
                                                            5),
                                                  ),
                                                  TextStyleWidget(
                                                      snapshot
                                                          .data!.company_name!,
                                                      Colors.black,
                                                      SizeConfig.scaleTextFont(
                                                          10),
                                                      FontWeight.w500),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.scaleHeight(10),
                                              ),
                                              Container(
                                                width:
                                                    SizeConfig.scaleWidth(99),
                                                height:
                                                    SizeConfig.scaleHeight(26),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Color(0xff4C5175),
                                                ),
                                                child: Center(
                                                  child: TextStyleWidget(
                                                      requestStatusProvider
                                                          .submittedJobs[index]
                                                          .status!,
                                                      Colors.white,
                                                      SizeConfig.scaleTextFont(
                                                          10),
                                                      FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              );
      }),
    );
  }
}
