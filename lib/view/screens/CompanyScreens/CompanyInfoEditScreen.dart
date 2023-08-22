import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:provider/provider.dart';

import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../../providers/ComInfoProvider.dart';
import '../../customWidget/textStyleWidget.dart';

class CompanyInfoEdit extends StatefulWidget {
  static const String id = "company_info_edit_screen";




  @override
  State<CompanyInfoEdit> createState() => _CompanyInfoEditState();
}

class _CompanyInfoEditState extends State<CompanyInfoEdit> {
  TextEditingController? _company_name;
  TextEditingController? _phone;
  TextEditingController? _address;
  TextEditingController? _company_manger;
  TextEditingController? _about;

  late Company company;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    company = Provider
        .of<ComInfoProvider>(context, listen: false)
        .comInfoList
        .first;


    _company_name = TextEditingController(text: company.companyName!);
    _phone = TextEditingController(text: company.phone);
    _address = TextEditingController(text: company.address);
    _company_manger = TextEditingController(text: company.managerName);
    _about = TextEditingController(text: company.about);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _company_name?.dispose();
    _phone?.dispose();
    _address?.dispose();
    _company_manger?.dispose();
    _about?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
      ),
      body:
      Consumer<ComInfoProvider>(
          builder: (context, comInfoProvider, _) {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig.scaleWidth(20),
                end: SizeConfig.scaleWidth(20),
                top: SizeConfig.scaleHeight(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleWidget(
                        company.companyName != null
                            ? company.companyName ?? ""
                            : "No companyName",
                        Color(0xffCBB523),
                        SizeConfig.scaleTextFont(20), FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              company.image != null
                                  ? company.image ?? ""
                                  : "No image",
                              width: SizeConfig.scaleWidth(120),
                              height: SizeConfig.scaleHeight(120),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: SizeConfig.scaleHeight(0),
                            right: SizeConfig.scaleWidth(0),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: FloatingActionButton(
                                  backgroundColor: Color(0xff4C5175),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: SizeConfig.scaleWidth(20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextStyleWidget("Company Name:", Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12), FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: TextField(
                        controller: _company_name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextStyleWidget("phone", Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12), FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: TextField(
                        controller: _phone,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextStyleWidget("address", Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12), FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: TextField(
                        controller: _address,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextStyleWidget(
                          "Company Manager:", Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12), FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: TextField(
                        controller: _company_manger,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextStyleWidget(
                          "Company Manager image:",
                          Color(0xff4C5175),
                          SizeConfig.scaleTextFont(12),
                          FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.camera_alt_outlined,
                            size: SizeConfig.scaleWidth(20),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "ahmed.png",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.scaleTextFont(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    TextStyleWidget("About Company:", Color(0xff4C5175),
                        SizeConfig.scaleTextFont(15), FontWeight.w500),
                    SizedBox(
                      height: SizeConfig.scaleHeight(5),
                    ),
                    SizedBox(
                      child: TextField(
                        controller: _about,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Center(
                      child: Container(
                        height: SizeConfig.scaleHeight(60),
                        width: SizeConfig.scaleWidth(320),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff4C5175),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: ()async {
                              await performUpdate();
                              Fluttertoast.showToast(
                                msg: "Updated successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return CompanyInfo();
                              }));
                            },
                            child: TextStyleWidget("Save ", Colors.white,
                                SizeConfig.scaleTextFont(20), FontWeight.w500)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  Future performUpdate() async {
    if (checkData())
      await update();
  }

  bool checkData() {
    if (_company_name!.text.isNotEmpty &&
        _phone!.text.isNotEmpty &&
        _address!.text.isNotEmpty &&
        _company_manger!.text.isNotEmpty &&
        _about!.text.isNotEmpty
    )
      return true;
    else
      print("can't be null");
    return false;
  }

  Future update() async {
    await FirebaseFireStoreHelper.instance.updateCompanyProfileInfo(getCompanyInfo());
    Navigator.pop(context);

  }
  Company getCompanyInfo(){
    return Company(
      companyName:_company_name!.text ,
      phone:_phone!.text,
      address:_address!.text,
      managerName:_company_manger!.text,
      about:_about!.text,
      facebookAccount:company.facebookAccount,
      twitterAccount:company.twitterAccount,
      InstagramAccount:company.InstagramAccount,
      image:company.image,
      managerImage:company.managerImage,
      email: company.email,
    );
  }
}
