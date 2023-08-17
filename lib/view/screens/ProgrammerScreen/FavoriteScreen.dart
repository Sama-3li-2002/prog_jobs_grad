import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/SubmitJopScreen.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UsersModel.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'ProfileInfoScreen.dart';

class Favorite extends StatefulWidget {
  static const String id = "favorite_screen";

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
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
                      child: CircleAvatar(
                        backgroundImage: users!.imageUrl != null
                            ? NetworkImage(users!.imageUrl!)
                            : null,
                      )),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                child: TextStyleWidget('Favourites', Color(0xffcbb523),
                    SizeConfig.scaleTextFont(15), FontWeight.w500),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
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
                            child: Image.asset(
                              'assets/images/computer.png',
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
                                          'Web Programmer',
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
                                            size: SizeConfig.scaleWidth(15),
                                            color: Color(0xffcbb523),
                                          ),
                                          TextStyleWidget(
                                              ' Magic Company',
                                              Colors.black,
                                              SizeConfig.scaleTextFont(10),
                                              FontWeight.w500),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: SizeConfig.scaleWidth(14),
                                            color: Color(0xffcbb523),
                                          ),
                                          TextStyleWidget(
                                              ' a minute ago',
                                              Colors.black,
                                              SizeConfig.scaleTextFont(10),
                                              FontWeight.w500),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(120),
                                        height: SizeConfig.scaleHeight(26),
                                        child: ElevatedButton(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.touch_app_outlined,
                                                color: Color(0xffcbb523),
                                                size: SizeConfig.scaleWidth(14),
                                              ),
                                              SizedBox(
                                                  width: SizeConfig.scaleWidth(
                                                      10)),
                                              TextStyleWidget(
                                                  'Submition',
                                                  Colors.white,
                                                  SizeConfig.scaleTextFont(10),
                                                  FontWeight.w500),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SubmitJopScreen();
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
                                      IconButton(
                                        alignment: Alignment.centerRight,
                                        icon: Icon(
                                          Icons.favorite,
                                          size: SizeConfig.scaleWidth(20),
                                        ),
                                        color: Color(
                                          0xffcbb523,
                                        ),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ],
          ),
        ));
  }
}
