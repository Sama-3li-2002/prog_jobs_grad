import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/customWidget/DrawerWidget.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/no_of_request.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import '../ProgrammerScreen/JobDetailsScreen.dart';
import 'AddNewJobScreen.dart';
import 'com_all_jobs.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ComHomeScreen extends StatefulWidget {
  static const String id = "com_home_screen";
  CarouselController _carouselController = CarouselController();

  final List<String> imagePaths = [
    'assets/images/jomhoorak.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
  ];

  @override
  State<ComHomeScreen> createState() => _ComHomeScreenState();
}

class _ComHomeScreenState extends State<ComHomeScreen> {
  int _currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.list,
              size: SizeConfig.scaleWidth(22),
            ),
            color: Color(0xff4C5175),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(22),
            ),
            color: Color(0xff4C5175),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddNewJobScreen();
              }));
            },
            icon: Icon(
              Icons.add_card,
              size: SizeConfig.scaleWidth(22),
            ),
            color: Color(0xff4C5175),
          ),
        ],
      ),
      backgroundColor: Color(0xfffafafa),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              carouselController: widget._carouselController,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlideIndex = index;
                  });
                },
              ),
              items: widget.imagePaths.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      width: SizeConfig.screenWidth,
                      child: Image.asset(path, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imagePaths.map((path) {
                int index = widget.imagePaths.indexOf(path);
                return Container(
                  width: SizeConfig.scaleWidth(20),
                  height: SizeConfig.scaleHeight(8),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    color:
                        _currentSlideIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.scaleWidth(10),
                top: SizeConfig.scaleWidth(10),
              ),
              child: TextStyleWidget(
                'New Jobs:',
                Color(0xffCBB523),
                SizeConfig.scaleTextFont(15),
                FontWeight.w500,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    margin: EdgeInsets.all(
                      SizeConfig.scaleWidth(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return JobDetailsScreen();
                        }));
                      },
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
                                            ' Magic Company',
                                            Colors.black,
                                            SizeConfig.scaleTextFont(10),
                                            FontWeight.w500,
                                          ),
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
                                            FontWeight.w500,
                                          ),
                                        ],
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
                                                width:
                                                    SizeConfig.scaleWidth(18),
                                                child: Text(
                                                  '12',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    backgroundColor:
                                                        Color(0xffcbb523),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig
                                                        .scaleTextFont(10),
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
                                      IconButton(
                                        alignment: Alignment.centerRight,
                                        icon: Icon(
                                          Icons.bookmark_border,
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
                      ),
                    ));
              },
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(10),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(10)),
              child: Row(
                children: [
                  TextStyleWidget(
                    'All Jobs:',
                    Color(0xffcbb523),
                    SizeConfig.scaleTextFont(15),
                    FontWeight.w500,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ComAllJobScreen();
                      }));
                    },
                    child: TextStyleWidget(
                      'see all',
                      Color(0xffCB3423),
                      SizeConfig.scaleTextFont(12),
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
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
                                          ' Magic Company',
                                          Colors.black,
                                          SizeConfig.scaleTextFont(10),
                                          FontWeight.w500,
                                        ),
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
                                          FontWeight.w500,
                                        ),
                                      ],
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
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(
                                        Icons.bookmark_border,
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
      ),
    );
  }
}
