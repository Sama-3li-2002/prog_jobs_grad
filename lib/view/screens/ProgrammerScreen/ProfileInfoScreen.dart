import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/NotificationsScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoEditScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';

import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UsersModel.dart';
import '../../../utils/size_config.dart';
import 'home.dart';

class ProfileInfo extends StatefulWidget {
  static const String id = "profile_info_screen";
  String? idProg;

  ProfileInfo(this.idProg);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;

  Users? users;

  Future getUser() async {
    final userResult = await fireStoreHelper.getUserData(widget.idProg!);
    setState(() {
      users = userResult;
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();
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
            if (UserTypeScreen.type == 'programmer') {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(20),
          ),
          color: Color(0xff4C5175),
        ),
        actions: [
          if (UserTypeScreen.type == 'programmer')
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
                  size: SizeConfig.scaleWidth(30),
                ))
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
                        child: CircleAvatar(
                          backgroundImage: users!.imageUrl != null
                              ? NetworkImage(users!.imageUrl)
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
                                    constraints: BoxConstraints(minHeight: 420),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(25),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "E_mail:",
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          12),
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
                                                bottom:
                                                    SizeConfig.scaleHeight(15),
                                              ),
                                              child: Text(
                                                users!.email.toString(),
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(12),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
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
                                                bottom:
                                                    SizeConfig.scaleHeight(15),
                                              ),
                                              child: Text(
                                                users!.age.toString(),
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(12),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
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
                                                bottom:
                                                    SizeConfig.scaleHeight(15),
                                              ),
                                              child: Text(
                                                users!.phone.toString(),
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(12),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
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
                                                right:
                                                    SizeConfig.scaleWidth(10),
                                                bottom:
                                                    SizeConfig.scaleHeight(15),
                                              ),
                                              child: Text(
                                                users!.about.toString(),
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(13),
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
                          if (UserTypeScreen.type == 'programmer')
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
