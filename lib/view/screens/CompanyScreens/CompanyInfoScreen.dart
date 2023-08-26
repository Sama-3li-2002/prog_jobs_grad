import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/CompanyModel.dart';
import 'package:provider/provider.dart';
import '../../../providers/ComInfoProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'CompanyInfoEditScreen.dart';

class CompanyInfo extends StatefulWidget {
  static const String id = "company_info_screen";

  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  late List<Company> comInfo;

  @override
  void initState() {
    super.initState();
    Provider.of<ComInfoProvider>(context, listen: false).getComInfoObjects();
    comInfo = ComInfoProvider().comInfoList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ComInfoProvider>(
          builder: (context, comInfoProvider, _) => comInfoProvider
                  .comInfoList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/company_info_image.jpg",
                            height: SizeConfig.scaleHeight(220),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: Colors.black.withOpacity(0.8),
                            colorBlendMode: BlendMode.darken,
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: SizeConfig.scaleWidth(30),
                                      top: SizeConfig.scaleHeight(50)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: SizeConfig.scaleWidth(20),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: SizeConfig.scaleWidth(300),
                                      top: SizeConfig.scaleHeight(50)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return CompanyInfoEdit();
                                      }));
                                    },
                                    child: Icon(Icons.edit_sharp,
                                        color: Colors.white,
                                        size: SizeConfig.scaleWidth(23)),
                                  )),
                            ],
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.scaleHeight(150)),
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: comInfoProvider.comInfoList[0].image !=
                                          null
                                      ? Image.network(
                                          comInfoProvider.comInfoList[0].image!,
                                          width: SizeConfig.scaleWidth(120),
                                          height: SizeConfig.scaleHeight(120),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/prog-jobs-grad.appspot.com/o/com_images%2FwithoutImageCompany.png?alt=media&token=98b7a6e2-b895-4254-bed0-598c5f10ec2b')),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        comInfoProvider.comInfoList.isNotEmpty
                            ? comInfoProvider.comInfoList[0].companyName ?? ""
                            : "No company name available",
                        style: TextStyle(
                            color: Color(0xffCBB523),
                            fontSize: SizeConfig.scaleTextFont(18),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig.scaleWidth(30),
                            top: SizeConfig.scaleHeight(10)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.apartment,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(20),
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(10),
                            ),
                            Text(
                              comInfoProvider.comInfoList.isNotEmpty
                                  ? comInfoProvider
                                          .comInfoList[0].companyName ??
                                      ""
                                  : "No company name available",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.scaleTextFont(12),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: SizeConfig.scaleWidth(30),
                          top: SizeConfig.scaleHeight(5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.alternate_email,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(20),
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(10),
                            ),
                            Text(
                              comInfoProvider.comInfoList.isNotEmpty
                                  ? comInfoProvider.comInfoList[0].email ?? ""
                                  : "No email available",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.scaleTextFont(12),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig.scaleWidth(30),
                            top: SizeConfig.scaleHeight(5)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(20),
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(10),
                            ),
                            Text(
                              comInfoProvider.comInfoList.isNotEmpty
                                  ? comInfoProvider.comInfoList[0].address ?? ""
                                  : "No address available",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.scaleTextFont(12),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig.scaleWidth(30),
                            top: SizeConfig.scaleHeight(5)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(20),
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(10),
                            ),
                            Text(
                              comInfoProvider.comInfoList.isNotEmpty
                                  ? comInfoProvider.comInfoList[0].phone ?? ""
                                  : "No phone available",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.scaleTextFont(12),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        // height: SizeConfig.scaleHeight(800),
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.only(
                          top: SizeConfig.scaleHeight(20),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 50,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(300),
                                width: double.infinity,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const PageScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.asset(
                                          "assets/images/advertisement 1.jpeg"),
                                      margin: EdgeInsetsDirectional.only(
                                        top: SizeConfig.scaleHeight(30),
                                        bottom: SizeConfig.scaleHeight(10),
                                        start: SizeConfig.scaleWidth(10),
                                        end: SizeConfig.scaleWidth(5),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.asset(
                                        "assets/images/advertisement 2.jpg",
                                      ),
                                      margin: EdgeInsetsDirectional.only(
                                        top: SizeConfig.scaleHeight(30),
                                        bottom: SizeConfig.scaleHeight(10),
                                        start: SizeConfig.scaleWidth(5),
                                        end: SizeConfig.scaleWidth(5),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.asset(
                                        "assets/images/advertisement 3.jpg",
                                      ),
                                      margin: EdgeInsetsDirectional.only(
                                        top: SizeConfig.scaleHeight(30),
                                        bottom: SizeConfig.scaleHeight(10),
                                        start: SizeConfig.scaleWidth(5),
                                        end: SizeConfig.scaleWidth(5),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.scaleHeight(10),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig.scaleWidth(10)),
                                child: TextStyleWidget(
                                    "About Company :",
                                    Color(0xffCBB523),
                                    SizeConfig.scaleTextFont(20),
                                    FontWeight.w500),
                              ),
                              Container(
                                // height: SizeConfig.scaleHeight(400),
                                // width: double.infinity,
                                margin: EdgeInsetsDirectional.only(
                                  top: SizeConfig.scaleHeight(10),
                                  bottom: SizeConfig.scaleHeight(10),
                                  start: SizeConfig.scaleWidth(10),
                                  end: SizeConfig.scaleWidth(10),
                                ),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: SizeConfig.scaleHeight(15),
                                      bottom: SizeConfig.scaleHeight(10),
                                      start: SizeConfig.scaleWidth(20),
                                      end: SizeConfig.scaleWidth(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                comInfoProvider
                                                        .comInfoList.isNotEmpty
                                                    ? comInfoProvider
                                                            .comInfoList[0]
                                                            .managerImage ??
                                                        ""
                                                    : "No Image",
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(15),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: SizeConfig.scaleHeight(
                                                      8)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextStyleWidget(
                                                      comInfoProvider
                                                              .comInfoList
                                                              .isNotEmpty
                                                          ? comInfoProvider
                                                                  .comInfoList[
                                                                      0]
                                                                  .managerName ??
                                                              ""
                                                          : "No manger name available",
                                                      Colors.black,
                                                      SizeConfig.scaleTextFont(
                                                          18),
                                                      FontWeight.w500),
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            2),
                                                  ),
                                                  TextStyleWidget(
                                                      "Company Manager:",
                                                      Colors.grey,
                                                      SizeConfig.scaleTextFont(
                                                          14),
                                                      FontWeight.w500)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(15),
                                        ),
                                        AutoSizeText(
                                          comInfoProvider.comInfoList.isNotEmpty
                                              ? comInfoProvider
                                                      .comInfoList[0].about ??
                                                  ""
                                              : "No data available",
                                          maxLines: 13,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize:
                                                  SizeConfig.scaleTextFont(15),
                                              wordSpacing: 2),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
