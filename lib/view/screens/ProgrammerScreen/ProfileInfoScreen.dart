import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/NotificationsScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoEditScreen.dart';

import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UsersModel.dart';
import '../../../utils/size_config.dart';

class ProfileInfo extends StatefulWidget {
  static const String id = "profile_info_screen";

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
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

  @override
  void initState() {
    super.initState();

    users = Users();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // getUser();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(14),
          ),
          color: Color(0xff4C5175),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NotificationScreen();
                }));
              },
              icon: Icon(
                Icons.notifications_active,
                color: Color(0xff4C5175),
                size: SizeConfig.scaleWidth(22),
              ))
        ],
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
      ),
      body: Center(
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
                  child: CircleAvatar(
                    backgroundImage: users!.imageUrl != null
                        ? NetworkImage(users!.imageUrl!)
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              Text(
                users!.username.toString(),
                style: TextStyle(
                    color: Color(0xff4C5175),
                    fontSize: SizeConfig.scaleTextFont(19),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(3),
              ),
              Text(
                users!.specialization.toString(),
                style: TextStyle(
                    color: Color(0xffBBBDD0),
                    fontSize: SizeConfig.scaleTextFont(14),
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.scaleHeight(10),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: SizeConfig.scaleHeight(30),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.scaleHeight(60),
                              left: SizeConfig.scaleWidth(20),
                              right: SizeConfig.scaleWidth(20),
                            ),
                            child: Container(
                              constraints: BoxConstraints(minHeight: 380),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "E_mail:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: SizeConfig.scaleHeight(48),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(10),
                                          top: SizeConfig.scaleHeight(15),
                                          bottom: SizeConfig.scaleHeight(15),
                                        ),
                                        child: Text(
                                          users!.email.toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                              color: Colors.black),
                                        ),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Age:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: SizeConfig.scaleHeight(48),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(10),
                                          top: SizeConfig.scaleHeight(15),
                                          bottom: SizeConfig.scaleHeight(15),
                                        ),
                                        child: Text(
                                          users!.age.toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                              color: Colors.black),
                                        ),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Phone:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: SizeConfig.scaleHeight(48),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(10),
                                          top: SizeConfig.scaleHeight(15),
                                          bottom: SizeConfig.scaleHeight(15),
                                        ),
                                        child: Text(
                                          users!.phone.toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                              color: Colors.black),
                                        ),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "About:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(10),
                                          top: SizeConfig.scaleHeight(15),
                                          right: SizeConfig.scaleWidth(10),
                                          bottom: SizeConfig.scaleHeight(15),
                                        ),
                                        child: Text(
                                          users!.about.toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.scaleTextFont(13),
                                              color: Colors.black,
                                              wordSpacing: 4),
                                        ),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: SizeConfig.scaleWidth(80),
                        height: SizeConfig.scaleHeight(80),
                        child: CircleAvatar(
                          backgroundColor: Color(0xff4C5175),
                          radius: 50,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return ProfileInfoEdit();
                              }));
                            },
                            icon: Icon(
                              Icons.mode_edit,
                              size: SizeConfig.scaleWidth(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
