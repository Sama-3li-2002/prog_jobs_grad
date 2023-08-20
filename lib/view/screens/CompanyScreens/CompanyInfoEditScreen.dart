import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';

import '../../customWidget/textStyleWidget.dart';

class CompanyInfoEdit extends StatefulWidget {
  static const String id = "company_info_edit_screen";

  @override
  State<CompanyInfoEdit> createState() => _CompanyInfoEditState();
}

class _CompanyInfoEditState extends State<CompanyInfoEdit> {
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
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig.scaleWidth(20),
          end: SizeConfig.scaleWidth(20),
          top: SizeConfig.scaleHeight(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleWidget("Technology Magic", Color(0xffCBB523),
                  SizeConfig.scaleTextFont(20), FontWeight.w500),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/technologyCompany.png",
                      width: 200,
                      height: 100,
                    ),
                    Positioned(
                      bottom: SizeConfig.scaleHeight(0),
                      right: SizeConfig.scaleWidth(30),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: FloatingActionButton(
                            backgroundColor: Color(0xff4C5175),
                            onPressed: () {},
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: SizeConfig.scaleWidth(22),
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "technology magic company",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.scaleTextFont(12),
                    ),
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
                child: TextStyleWidget("E_mail:", Color(0xff4C5175),
                    SizeConfig.scaleTextFont(12), FontWeight.w500),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(5),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "technology.magic28@gmail.com",
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "0592 066 269",
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "Gaza_alNasr_Dawar Hamid",
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
              Align(
                alignment: Alignment.topLeft,
                child: TextStyleWidget("Company Manager:", Color(0xff4C5175),
                    SizeConfig.scaleTextFont(12), FontWeight.w500),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(5),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "Eng.Ahmed Khaled Saed",
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
                height: SizeConfig.scaleHeight(8),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(360),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 13,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffFAFAFA),
                    hintText: "Excepteur sint occaecat cupidatat non proident,"
                        " sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. "
                        "Sed ut perspiciatis unde omnis istpoe natus error sit"
                        " voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, "
                        "eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae "
                        "dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.scaleTextFont(14),
                        fontFamily: "Poppins"),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        color: Colors.grey.shade500,
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
                  // margin: EdgeInsetsDirectional.only(start:SizeConfig.scaleWidth(250)),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff4C5175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
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
      ),
    );
  }
}
