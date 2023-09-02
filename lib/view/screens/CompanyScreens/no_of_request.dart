import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AcceptPersonScreen.dart';
import 'package:provider/provider.dart';
import '../../../model/JobsModel.dart';
import '../../../providers/NumberOfRequestsProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/ShowProfPicInCom.dart';
import '../../customWidget/textStyleWidget.dart';

class NumberOfRequestsScreen extends StatefulWidget {
  static const String id = "no_of_request_screen";

  Jobs jobs;

  NumberOfRequestsScreen({required this.jobs});

  @override
  State<NumberOfRequestsScreen> createState() => _NumberOfRequestsScreenState();
}

class _NumberOfRequestsScreenState extends State<NumberOfRequestsScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<NumberOfRequestsProvider>(context, listen: false)
        .getSubmittedRequests(widget.jobs.job_id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xffFFFFFFFF),
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
          title:    TextStyleWidget(
            'Requests',
            Color(0xffcbb523),
            SizeConfig.scaleTextFont(17),
            FontWeight.bold,
          ),

        ),

        body: Consumer<NumberOfRequestsProvider>(
            builder: (context, NoOfRequestsProvider, _) {
          return NoOfRequestsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : NoOfRequestsProvider.submittedRequests.isEmpty
                  ? Center(
                      child: Text("There is No Submitted Request On This Job"))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ListView.builder(
                              itemCount:
                                  NoOfRequestsProvider.submittedRequests.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int index) {

                                // لازالة الثواني من الوقت
                                late String formattedTime;
                                String timeString =  NoOfRequestsProvider.submittedRequests
                                    [index].current_time ??
                                    "";
                                try {
                                  formattedTime = DateFormat('hh:mm a').format(
                                      DateFormat('hh:mm:ss a').parse(timeString));
                                } catch (e) {
                                  print("Invalid data format: $timeString");
                                  formattedTime = "Invalid time format";
                                }



                                return Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AcceptPerson(
                                            progId: NoOfRequestsProvider
                                                .submittedRequests[index]
                                                .ProgId!,
                                            fileUrl: NoOfRequestsProvider
                                                .submittedRequests[index]
                                                .fileUrl!,
                                            uploadedFileName:
                                                NoOfRequestsProvider
                                                    .submittedRequests[index]
                                                    .uploadedFileName!,
                                            request_status: NoOfRequestsProvider
                                                .submittedRequests[index]
                                                .status!,
                                            jobId: NoOfRequestsProvider
                                                .submittedRequests[index]
                                                .JobId!,
                                          );
                                        }));
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        margin: EdgeInsets.all(
                                          SizeConfig.scaleWidth(15),
                                        ),
                                        child: Material(
                                          elevation: 2,
                                          child: Container(
                                              height:
                                                  SizeConfig.scaleHeight(80),
                                              width: SizeConfig.scaleWidth(360),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  ),
                                              margin: EdgeInsets.only(
                                                left: SizeConfig.scaleWidth(15),
                                                right:
                                                    SizeConfig.scaleWidth(15),
                                                bottom:
                                                    SizeConfig.scaleHeight(10),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.all(
                                                      SizeConfig.scaleWidth(8)),
                                                  child: Row(children: [
                                                    Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape: CircleBorder(),
                                                        elevation: 4,
                                                        color:
                                                            Color(0xffcbb523),
                                                        child: SizedBox(
                                                            width: SizeConfig
                                                                .scaleWidth(60),
                                                            height: SizeConfig
                                                                .scaleHeight(
                                                                    100),
                                                            child:
                                                                ShowProfPicInCom(
                                                              ProgId: NoOfRequestsProvider
                                                                  .submittedRequests[
                                                                      index]
                                                                  .ProgId!,
                                                            ))),
                                                    Flexible(
                                                      child: Column(
                                                        children: [
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              TextStyleWidget(
                                                                widget.jobs
                                                                    .job_name!,
                                                                Color(
                                                                    0xff4C5175),
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                        15),
                                                                FontWeight.w500,
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding:  EdgeInsets.only(right: 5.0),
                                                                child: TextStyleWidget(
                                                                  formattedTime
                                                                  ,
                                                                  Color(
                                                                      0xff4C5175),
                                                                  SizeConfig
                                                                      .scaleTextFont(
                                                                          10),
                                                                  FontWeight.w500,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .account_circle,
                                                                size: SizeConfig
                                                                    .scaleWidth(
                                                                        15),
                                                                color: Color(
                                                                    0xffcbb523),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              TextStyleWidget(
                                                                NoOfRequestsProvider
                                                                    .submittedRequests[
                                                                        index]
                                                                    .fullName!,
                                                                Colors.black,
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                        10),
                                                                FontWeight.w500,
                                                              ),
                                                              Spacer(),
                                                              TextStyleWidget(
                                                                NoOfRequestsProvider
                                                                    .submittedRequests[
                                                                        index]
                                                                    .current_date!,
                                                                Color(
                                                                    0xff4C5175),
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                        10),
                                                                FontWeight.w500,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    )
                                                  ]))),
                                        ),
                                      ))
                                ]);
                              })
                        ],
                      ),
                    );
        }));
  }


}
