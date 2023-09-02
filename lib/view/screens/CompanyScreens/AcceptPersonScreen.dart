import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/pdf_viewer_page.dart';
import 'package:http/http.dart' as http;
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../../model/JobsModel.dart';
import '../../../notification_service.dart';
import '../../customWidget/ShowProfPicInCom.dart';
import '../../customWidget/textStyleWidget.dart';
import 'no_of_request.dart';

class AcceptPerson extends StatefulWidget {
  static const String id = "accept_person_screen";

  String progId;
  String fileUrl;
  String uploadedFileName;
  String request_status;
  String jobId;
  String comName;
  String comId;
  Jobs jobs;

  AcceptPerson({
    required this.progId,
    required this.fileUrl,
    required this.uploadedFileName,
    required this.request_status,
    required this.jobId,
    required this.comName,
    required this.comId,
    required this.jobs,
  });

  @override
  State<AcceptPerson> createState() => _AcceptPersonState();
}

class _AcceptPersonState extends State<AcceptPerson> {
  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;
  Users? users;
  NotificationServices notificationServices = NotificationServices();

  List<Company> comInfoList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchUserData();
      getComInfo(widget.comId);
    });

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return NumberOfRequestsScreen(
                jobs: widget.jobs,
                com_name: widget.comName,
              );
            }));
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
                return ConversationScreen();
              }));
            },
            icon: Icon(
              Icons.message,
              size: SizeConfig.scaleWidth(30),
            ),
            color: Color(0xff4C5175),
          ),
        ],
        elevation: 0,
      ),
      body: users == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      color: Color(0xffcbb523),
                      child: SizedBox(
                        width: SizeConfig.scaleWidth(150),
                        height: SizeConfig.scaleHeight(150),
                        child: ShowProfPicInCom(
                          ProgId: widget.progId,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(10)),
                    Column(
                      children: [
                        Container(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.scaleHeight(30),
                                  left: SizeConfig.scaleWidth(20),
                                  right: SizeConfig.scaleWidth(20)),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextStyleWidget(
                                            "Programmer's name:",
                                            Color(0xffCBB523),
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                        SizedBox(
                                          width: SizeConfig.scaleWidth(5),
                                        ),
                                        TextStyleWidget(
                                            users!.username!,
                                            Colors.black,
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(10),
                                    ),
                                    Row(
                                      children: [
                                        TextStyleWidget(
                                            "E_Mail:",
                                            Color(0xffCBB523),
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500),
                                        SizedBox(
                                          width: SizeConfig.scaleWidth(10),
                                        ),
                                        TextStyleWidget(
                                            users!.email!,
                                            Colors.black,
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(10),
                                    ),
                                    Row(
                                      children: [
                                        TextStyleWidget(
                                            "Specialization:",
                                            Color(0xffCBB523),
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500),
                                        SizedBox(
                                          width: SizeConfig.scaleWidth(10),
                                        ),
                                        TextStyleWidget(
                                            users!.specialization!,
                                            Colors.black,
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(10),
                                    ),
                                    Row(
                                      children: [
                                        TextStyleWidget(
                                            "Age:",
                                            Color(0xffCBB523),
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500),
                                        SizedBox(
                                          width: SizeConfig.scaleWidth(10),
                                        ),
                                        TextStyleWidget(
                                            users!.age!.toString() +
                                                " Years Old",
                                            Colors.black,
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(10),
                                    ),
                                    Row(
                                      children: [
                                        TextStyleWidget(
                                            "Phone:",
                                            Color(0xffCBB523),
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w500),
                                        SizedBox(
                                          width: SizeConfig.scaleWidth(10),
                                        ),
                                        TextStyleWidget(
                                            users!.phone!,
                                            Colors.black,
                                            SizeConfig.scaleTextFont(15),
                                            FontWeight.w500),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(30),
                                    ),
                                    TextStyleWidget(
                                        "About : ",
                                        Color(0xffCBB523),
                                        SizeConfig.scaleTextFont(17),
                                        FontWeight.w500),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(5),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        // height: SizeConfig.scaleHeight(300),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig.scaleWidth(10),
                                              top: SizeConfig.scaleHeight(17),
                                              bottom:
                                                  SizeConfig.scaleHeight(15),
                                              right: SizeConfig.scaleWidth(10)),
                                          child: Text(
                                            users!.about!,
                                            maxLines: 15,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.scaleTextFont(
                                                        15),
                                                color: Colors.black,
                                                wordSpacing: 4),
                                          ),
                                        )),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(10),
                                    ),
                                    TextStyleWidget(
                                        "CV : ",
                                        Color(0xffCBB523),
                                        SizeConfig.scaleTextFont(17),
                                        FontWeight.w500),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(5),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: SizeConfig.scaleHeight(60),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfViewerPage(
                                                            fileUrl:
                                                                widget.fileUrl,
                                                            fileName: widget
                                                                .uploadedFileName)));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    SizeConfig.scaleWidth(10),
                                              ),
                                              Icon(
                                                Icons.picture_as_pdf,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width:
                                                    SizeConfig.scaleWidth(10),
                                              ),
                                              Text(
                                                widget.uploadedFileName,
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(15),
                                                    color: Colors.black,
                                                    wordSpacing: 4),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(20),
                                    ),
                                    widget.request_status == 'waiting reply'
                                        ? Row(
                                            children: [
                                              Container(
                                                width:
                                                    SizeConfig.scaleWidth(150),
                                                child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xff4C5175),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        widget.request_status =
                                                            "Accepted Request";
                                                      });
                                                      DateTime now =
                                                          DateTime.now();
                                                      String amPm =
                                                          now.hour >= 12
                                                              ? 'PM'
                                                              : 'AM';

                                                      FirebaseFireStoreHelper
                                                          .instance
                                                          .updateRequest(
                                                              widget.jobId,
                                                              widget.progId,
                                                              widget
                                                                  .request_status);
                                                      notificationServices
                                                          .getDeviceToken()
                                                          .then((value) async {
                                                        var data = {
                                                          'to': users!
                                                              .deviceToken,
                                                          'notification': {
                                                            'title':
                                                                'Accepted Request',
                                                            'body':
                                                                'Your request has been Accepted! Tap to see more...',
                                                            'sound':
                                                                "jetsons_doorbell.mp3",
                                                          },
                                                          'data': {
                                                            'type': 'msj',
                                                            'id':
                                                                '803404929042',
                                                            'content': "Your application has been accepted at ${widget.comName} ... "
                                                                "We Will Contact with you soon for an interview and agree on the details."
                                                                "\nCongratulations!",
                                                            'time': now.hour
                                                                    .toString() +
                                                                ":" +
                                                                now.minute
                                                                    .toString() +
                                                                " " +
                                                                amPm,
                                                            'date': now.year
                                                                    .toString() +
                                                                "/" +
                                                                now.month
                                                                    .toString() +
                                                                "/" +
                                                                now.day
                                                                    .toString(),
                                                            'companyName':
                                                                comInfoList[0]
                                                                    .companyName,
                                                            'companyImage':
                                                                comInfoList[0]
                                                                    .image,
                                                            'companyAddress':
                                                                comInfoList[0]
                                                                    .address,
                                                          }
                                                        };

                                                        await http.post(
                                                            Uri.parse(
                                                                'https://fcm.googleapis.com/fcm/send'),
                                                            body: jsonEncode(
                                                                data),
                                                            headers: {
                                                              'Content-Type':
                                                                  'application/json; charset=UTF-8',
                                                              'Authorization':
                                                                  'key=AAAAuw6qWBI:APA91bGX0y-hj6okmbF2mqwOay4Cn4KYczju4kuFPMc3_alc844p3gprsGnnfe_TalUDRWQP0xfia3bhUbh4d7zgj8Dw7VUVOcMrAG9qB6B3E8oHULZHsDVijvv1yMyYUykKN3Krh6nX'
                                                            }).then((value) {
                                                          if (kDebugMode) {
                                                            print(value.body
                                                                .toString());
                                                          }
                                                        }).onError((error,
                                                            stackTrace) {
                                                          if (kDebugMode) {
                                                            print(error);
                                                          }
                                                        });
                                                      });

                                                      FirebaseFireStoreHelper
                                                          .instance
                                                          .addNotification(
                                                              widget.progId,
                                                              widget.comId,
                                                              "Your application has been accepted at ${widget.comName} ... "
                                                              "We Will Contact with you soon for an interview and agree on the details."
                                                              "\nCongratulations!");
                                                    },
                                                    child: TextStyleWidget(
                                                        "Accept",
                                                        Colors.white,
                                                        SizeConfig
                                                            .scaleTextFont(17),
                                                        FontWeight.w500)),
                                              ),
                                              SizedBox(
                                                width:
                                                    SizeConfig.scaleWidth(35),
                                              ),
                                              Container(
                                                width:
                                                    SizeConfig.scaleWidth(150),
                                                child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xff4C5175),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        widget.request_status =
                                                            "Rejected Request";
                                                      });

                                                      DateTime now =
                                                          DateTime.now();
                                                      String amPm =
                                                          now.hour >= 12
                                                              ? 'PM'
                                                              : 'AM';

                                                      FirebaseFireStoreHelper
                                                          .instance
                                                          .updateRequest(
                                                              widget.jobId,
                                                              widget.progId,
                                                              widget
                                                                  .request_status);
                                                      notificationServices
                                                          .getDeviceToken()
                                                          .then((value) async {
                                                        var data = {
                                                          'to': users!
                                                              .deviceToken,
                                                          'notification': {
                                                            'title':
                                                                'Rejected Request',
                                                            'body':
                                                                'Your request has been Rejected! Good Luck',
                                                            'sound':
                                                                "jetsons_doorbell.mp3",
                                                          },
                                                          'data': {
                                                            'type': 'msj',
                                                            'id':
                                                                '803404929042',
                                                            'content':
                                                                "We are sorry to say that ... Your request has been Rejected! Good Luck",
                                                            'time': now.hour
                                                                    .toString() +
                                                                ":" +
                                                                now.minute
                                                                    .toString() +
                                                                " " +
                                                                amPm,
                                                            'date': now.year
                                                                    .toString() +
                                                                "/" +
                                                                now.month
                                                                    .toString() +
                                                                "/" +
                                                                now.day
                                                                    .toString(),
                                                            'companyName':
                                                                comInfoList[0]
                                                                    .companyName,
                                                            'companyImage':
                                                                comInfoList[0]
                                                                    .image,
                                                            'companyAddress':
                                                                comInfoList[0]
                                                                    .address,
                                                          }
                                                        };

                                                        await http.post(
                                                            Uri.parse(
                                                                'https://fcm.googleapis.com/fcm/send'),
                                                            body: jsonEncode(
                                                                data),
                                                            headers: {
                                                              'Content-Type':
                                                                  'application/json; charset=UTF-8',
                                                              'Authorization':
                                                                  'key=AAAAuw6qWBI:APA91bGX0y-hj6okmbF2mqwOay4Cn4KYczju4kuFPMc3_alc844p3gprsGnnfe_TalUDRWQP0xfia3bhUbh4d7zgj8Dw7VUVOcMrAG9qB6B3E8oHULZHsDVijvv1yMyYUykKN3Krh6nX'
                                                            }).then((value) {
                                                          if (kDebugMode) {
                                                            print(value.body
                                                                .toString());
                                                          }
                                                        }).onError((error,
                                                            stackTrace) {
                                                          if (kDebugMode) {
                                                            print(error);
                                                          }
                                                        });
                                                      });
                                                      FirebaseFireStoreHelper
                                                          .instance
                                                          .addNotification(
                                                              widget.progId,
                                                              widget.comId,
                                                              'We are sorry to say that ... Your request has been Rejected! Good Luck');
                                                    },
                                                    child: TextStyleWidget(
                                                        "Reject",
                                                        Colors.white,
                                                        SizeConfig
                                                            .scaleTextFont(17),
                                                        FontWeight.w500)),
                                              ),
                                            ],
                                          )
                                        : widget.request_status ==
                                                'Accepted Request'
                                            ? Container(
                                                margin: EdgeInsets.all(5),
                                                height:
                                                    SizeConfig.scaleHeight(50),
                                                width: SizeConfig.screenWidth,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff4C5175),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: TextStyleWidget(
                                                      "Accepted Request",
                                                      Colors.white,
                                                      SizeConfig.scaleTextFont(
                                                          20),
                                                      FontWeight.w500),
                                                ))
                                            : Container(
                                                margin: EdgeInsets.all(5),
                                                height:
                                                    SizeConfig.scaleHeight(50),
                                                width: SizeConfig.screenWidth,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff4C5175),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: TextStyleWidget(
                                                      "Rejected Request",
                                                      Colors.white,
                                                      SizeConfig.scaleTextFont(
                                                          20),
                                                      FontWeight.w500),
                                                )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> fetchUserData() async {
    final userResult = await fireStoreHelper.getUserData(widget.progId);
    setState(() {
      users = userResult;
    });
  }

  Future<List<Company>> getComInfo(String comId) async {
    comInfoList = await FirebaseFireStoreHelper.instance.getComInfoById(comId);
    return comInfoList;
  }
}
