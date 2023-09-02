import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/CompanyInfoScreenProg.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../customWidget/textStyleWidget.dart';
import 'SubmitJopScreen.dart';

class JobsDetails extends StatefulWidget {
  static const String id = "job_details_screen";
  late List<Jobs> items;
  late List<Company> itemsComInfo;

  JobsDetails({required this.items, required this.itemsComInfo});

  @override
  State<JobsDetails> createState() => _JobsDetailsState();
}

class _JobsDetailsState extends State<JobsDetails> {


  // circular
  bool _isLoading = false;


  String user_id = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper firestore_helper = FirebaseFireStoreHelper.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Image.asset(
                        "assets/images/image11.jpg",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.7),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CompanyInfoScreenProg(
                              itemsComInfo: widget.itemsComInfo);
                        }));
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: FractionalTranslation(
                        translation: Offset(0.0, 0.5),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            widget.itemsComInfo.isNotEmpty
                                ? widget.itemsComInfo[0].image ?? ""
                                : "No Image",
                            height: SizeConfig.scaleHeight(120),
                            width: SizeConfig.scaleWidth(120),
                            fit: BoxFit.cover,
                          ),
                        ),
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
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(65),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apartment,
                      color: Color(0xffCBB523),
                      size: SizeConfig.scaleWidth(15),
                    ),
                    TextStyleWidget(
                        widget.itemsComInfo.isNotEmpty
                            ? widget.itemsComInfo[0].companyName ?? ""
                            : "No Company Name",
                        Color(0xff4C5175),
                        SizeConfig.scaleTextFont(15),
                        FontWeight.w500),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(10),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleWidget(
                            widget.items.isNotEmpty
                                ? widget.items[0].job_name ?? ""
                                : "No Job Name",
                            Color(0xffCBB523),
                            SizeConfig.scaleTextFont(20),
                            FontWeight.bold),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextStyleWidget(
                              widget.items.isNotEmpty
                                  ? widget.items[0].salary! + "" + r"$/month" ?? ""
                                  : "No Salary",
                              Color(0xff000000),
                              SizeConfig.scaleTextFont(15),
                              FontWeight.w600),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        TextStyleWidget("Job description:", Color(0xff4C5175),
                            SizeConfig.scaleTextFont(15), FontWeight.w500),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextStyleWidget(
                                  widget.items.isNotEmpty
                                      ? widget.items[0].job_description ?? ""
                                      : "No Job Description",
                                  Colors.black,
                                  SizeConfig.scaleTextFont(12),
                                  FontWeight.normal),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(5),
                        ),
                        TextStyleWidget("required skills:", Color(0xff4C5175),
                            SizeConfig.scaleTextFont(15), FontWeight.w500),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.scaleWidth(20),
                                    top: SizeConfig.scaleHeight(10),
                                    bottom: SizeConfig.scaleHeight(10)),
                                child: TextStyleWidget(
                                    widget.items.isNotEmpty
                                        ? widget.items[0].required_skills_one ?? ""
                                        : "No required skills",
                                    Color(0xff091A20),
                                    SizeConfig.scaleTextFont(12),
                                    FontWeight.w500),
                              ),
                              if (widget.items
                                  .elementAt(0)
                                  .required_skills_two!
                                  .isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 1.5,
                                      color: Colors.grey.shade100,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom: SizeConfig.scaleHeight(10)),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items
                                                      .elementAt(0)
                                                      .required_skills_two ??
                                                  ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                              if (widget.items
                                  .elementAt(0)
                                  .required_skills_three!
                                  .isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 1.5,
                                      color: Colors.grey.shade100,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom: SizeConfig.scaleHeight(10)),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items[0]
                                                      .required_skills_three ??
                                                  ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                              if (widget.items
                                  .elementAt(0)
                                  .required_skills_four!
                                  .isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 1.5,
                                      color: Colors.grey.shade100,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(20),
                                          top: SizeConfig.scaleHeight(10),
                                          bottom: SizeConfig.scaleHeight(10)),
                                      child: TextStyleWidget(
                                          widget.items.isNotEmpty
                                              ? widget.items[0]
                                                      .required_skills_four ??
                                                  ""
                                              : "No required skills",
                                          Color(0xff091A20),
                                          SizeConfig.scaleTextFont(12),
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.scaleWidth(15),
                                  top: SizeConfig.scaleHeight(15)),
                              width: SizeConfig.scaleWidth(250),
                              height: SizeConfig.scaleHeight(35),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return SubmitJopScreen(
                                      itemsComInfo: widget.itemsComInfo,
                                      ComId: widget.items[0].id!,
                                      JobId: widget.items[0].job_id!,
                                    );
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff4C5175),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.touch_app_outlined,
                                        color: Color(0xffcbb523),
                                        size: SizeConfig.scaleWidth(20),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(10),
                                      ),
                                      TextStyleWidget(
                                          "Submition",
                                          Color(0xffFAFAFA),
                                          SizeConfig.scaleTextFont(13),
                                          FontWeight.w500)
                                    ]),
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.scaleWidth(15),
                                  top: SizeConfig.scaleHeight(15)),
                              height: SizeConfig.scaleHeight(35),
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool isJobFavorited =
                                      await isFav(widget.items[0].job_id!);

                                  if (isJobFavorited) {
                                    await firestore_helper.removeFromFavorites(
                                        user_id, widget.items[0].job_id!);
                                  } else {
                                    await firestore_helper.addToFavorites(
                                        user_id,
                                        widget.items[0].job_id!,
                                        widget.items[0].id!);
                                  }

                                  setState(() {
                                    isJobFavorited = !isJobFavorited;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff4C5175),
                                ),
                                child: Center(
                                  child: FutureBuilder<bool>(
                                    future: isFav(
                                      widget.items[0].job_id!,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        print('Error');
                                        return Icon(
                                          Icons.favorite_border_outlined,
                                          color: Color(0xffcbb523),
                                        );
                                      } else {
                                        return Icon(
                                          snapshot.data == true
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          size: SizeConfig.scaleWidth(20),
                                          color: Color(0xffcbb523),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ]),
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      // ),
    );
  }

  Future<bool> isFav(job_id) {
    return firestore_helper.isJobFavorited(user_id, job_id);
  }
}
