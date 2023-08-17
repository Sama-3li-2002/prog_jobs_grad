import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UsersModel.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class SubmitJopScreen extends StatefulWidget {
  static const String id = "submit_job_screen";

  @override
  State<SubmitJopScreen> createState() => _SubmitJopScreenState();
}

class _SubmitJopScreenState extends State<SubmitJopScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: SizeConfig.scaleHeight(300),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                  ),
                  child: Image.asset(
                    "assets/images/laptops.jpg",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CompanyInfo();
                    }));
                  },
                  child: FractionalTranslation(
                    translation: Offset(0.0, 0.5),
                    child: Image.asset("assets/images/technologyCompany.png",
                        height: SizeConfig.scaleHeight(150),
                        width: SizeConfig.scaleWidth(150)),
                  ),
                ),
                Positioned(
                  width: SizeConfig.screenWidth,
                  top: 10,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.scaleWidth(20),
                          ),
                          color: Color(0xffD2D0D0FF),
                        ),
                      ),
                      Spacer(),
                      InkWell(
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
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_sharp,
                    color: Color(0xffCBB523), size: SizeConfig.scaleWidth(15)),
                TextStyleWidget("Gaza_alNasr_Dawar Hamid", Color(0xff4C5175),
                    SizeConfig.scaleWidth(13), FontWeight.w500),
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/facebook.png",
                    width: SizeConfig.scaleWidth(30),
                    height: SizeConfig.scaleHeight(30),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(15),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/images/twitter.png",
                      width: SizeConfig.scaleWidth(30),
                      height: SizeConfig.scaleHeight(30)),
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(15),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/images/instagram.png",
                      width: SizeConfig.scaleWidth(30),
                      height: SizeConfig.scaleHeight(30)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleWidget("fullName", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(),
                  SizedBox(height: SizeConfig.scaleHeight(12)),
                  TextStyleWidget("E_mail:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("City:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("university:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("Specialization:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("skills:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  SizedBox(
                    height: SizeConfig.scaleHeight(90),
                    width: SizeConfig.scaleWidth(335),
                    child: TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'write...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.scaleTextFont(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("business link:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(
                    inputType: TextInputType.url,
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(12),
                  ),
                  TextStyleWidget("cv:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  TextFieldWidget(),
                  SizedBox(height: SizeConfig.scaleHeight(15)),
                  Center(
                    child: Container(
                      width: SizeConfig.scaleWidth(320),
                      height: SizeConfig.scaleHeight(48),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4C5175),
                          ),
                          child: TextStyleWidget("submit", Colors.white,
                              SizeConfig.scaleTextFont(20), FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
