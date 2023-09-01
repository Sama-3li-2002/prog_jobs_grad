import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:provider/provider.dart';

import '../../../model/CompanyModel.dart';
import '../../../providers/FavoriteProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/ProfWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'JobsDetails.dart';
import 'ProfileInfoScreen.dart';
import 'SubmitJopScreen.dart';

class Favorite extends StatefulWidget {
  static const String id = "favorite_screen";

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {


  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false)
        .getFavoriteJobsForUser(FirebaseAuthController.fireAuthHelper.userId());
  }

  FirebaseFireStoreHelper helper = FirebaseFireStoreHelper.instance;

  @override
  Widget build(BuildContext context) {
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
                    child: ProfWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
        body:
            Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _) {
              return favoriteProvider.isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : favoriteProvider.favoriteJobsList.isEmpty
                  ? Center(child: Text("No available favorite jobs"))
                  :SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.scaleWidth(10)),
                        child: TextStyleWidget('Favorites', Color(0xffcbb523),
                            SizeConfig.scaleTextFont(15), FontWeight.w500),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: favoriteProvider.favoriteJobsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // لازالة الثواني من الوقت
                          late String formattedTime;
                          String timeString =  favoriteProvider.favoriteJobsList[index].current_time ?? "";
                          try {
                            formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
                          } catch (e) {
                            print("Invalid data format: $timeString");
                            formattedTime = "Invalid time format";
                          }


                          return Container(
                              margin: EdgeInsets.all(
                                SizeConfig.scaleWidth(15),
                              ),
                              child: Material(
                                  elevation: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          List<Company> comInfo = await helper
                                              .getComInfoById(favoriteProvider
                                                  .favoriteJobsList[index].id!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return JobsDetails(
                                                items: [
                                                  favoriteProvider
                                                      .favoriteJobsList[index],
                                                ],
                                                itemsComInfo: comInfo,
                                              );
                                            }),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height:
                                                  SizeConfig.scaleHeight(110),
                                              padding: EdgeInsets.zero,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              )),
                                              child: Image.network(
                                                favoriteProvider
                                                    .favoriteJobsList[index]
                                                    .job_image!,
                                                fit: BoxFit.cover,
                                                width:
                                                    SizeConfig.scaleWidth(96),
                                                height:
                                                    SizeConfig.scaleHeight(105),
                                                color: Color(0xff4C5175)
                                                    .withOpacity(0.5),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: SizeConfig
                                                                  .scaleHeight(
                                                                      5)),
                                                          child: TextStyleWidget(
                                                              favoriteProvider
                                                                  .favoriteJobsList[
                                                                      index]
                                                                  .job_name!,
                                                              Color(0xff4C5175),
                                                              SizeConfig
                                                                  .scaleTextFont(
                                                                      15),
                                                              FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.apartment,
                                                              size: SizeConfig
                                                                  .scaleWidth(
                                                                      15),
                                                              color: Color(
                                                                  0xffcbb523),
                                                            ),
                                                            TextStyleWidget(
                                                                favoriteProvider
                                                                    .favoriteJobsList[
                                                                        index]
                                                                    .company_name!,
                                                                Colors.black,
                                                                SizeConfig
                                                                    .scaleTextFont(
                                                                        10),
                                                                FontWeight
                                                                    .w500),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .access_time,
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

                                                                      favoriteProvider
                                                                          .favoriteJobsList
                                                                          .isNotEmpty
                                                                          ? formattedTime??
                                                                          ""
                                                                          : "No Current Time",

                                                                      Colors
                                                                          .black,
                                                                      SizeConfig
                                                                          .scaleTextFont(
                                                                              10),
                                                                      FontWeight
                                                                          .w500),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left:16),
                                                                child: TextStyleWidget(
                                                                    favoriteProvider
                                                                        .favoriteJobsList[
                                                                    index]
                                                                        .current_date!,

                                                                    Colors.black,
                                                                    SizeConfig
                                                                        .scaleTextFont(
                                                                            10),
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: SizeConfig
                                                              .scaleWidth(120),
                                                          height: SizeConfig
                                                              .scaleHeight(26),
                                                          child: ElevatedButton(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .touch_app_outlined,
                                                                  color: Color(
                                                                      0xffcbb523),
                                                                  size: SizeConfig
                                                                      .scaleWidth(
                                                                          14),
                                                                ),
                                                                SizedBox(
                                                                    width: SizeConfig
                                                                        .scaleWidth(
                                                                            10)),
                                                                TextStyleWidget(
                                                                    'Submition',
                                                                    Colors
                                                                        .white,
                                                                    SizeConfig
                                                                        .scaleTextFont(
                                                                            10),
                                                                    FontWeight
                                                                        .w500),
                                                              ],
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              List<Company>
                                                                  comInfo =
                                                                  await helper.getComInfoById(
                                                                      favoriteProvider
                                                                          .favoriteJobsList[
                                                                              index]
                                                                          .id!);

                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return SubmitJopScreen(
                                                                  itemsComInfo:
                                                                      comInfo,
                                                                  ComId: favoriteProvider
                                                                      .favoriteJobsList[
                                                                          index]
                                                                      .id!,
                                                                  JobId: favoriteProvider
                                                                      .favoriteJobsList[
                                                                          index]
                                                                      .job_id!,
                                                                );
                                                              }));
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff4C5175),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        IconButton(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          icon: Icon(
                                                            Icons.favorite,
                                                            size: SizeConfig
                                                                .scaleWidth(20),
                                                          ),
                                                          color: Color(
                                                            0xffcbb523,
                                                          ),
                                                          onPressed: () async {
                                                            await favoriteProvider
                                                                .removeFromFavorites(
                                                                    favoriteProvider
                                                                        .favoriteJobsList[
                                                                            index]
                                                                        .job_id!);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))));
                        },
                      ),
                    ],
                  ),
                );
        }));
  }
}
