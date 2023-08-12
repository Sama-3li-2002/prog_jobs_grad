import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class ProfileInfoEdit extends StatefulWidget {
  static const String id = "profile_info_edit_screen";

  @override
  State<ProfileInfoEdit> createState() => _ProfileInfoEditState();
}

class _ProfileInfoEditState extends State<ProfileInfoEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
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
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/prof1.png',
                      fit: BoxFit.cover,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              Text(
                "Sohib naser khalaf",
                style: TextStyle(
                    color: Color(0xff4C5175),
                    fontSize: SizeConfig.scaleTextFont(19),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(3),
              ),
              Text(
                "Web programmer",
                style: TextStyle(
                    color: Color(0xffBBBDD0),
                    fontSize: SizeConfig.scaleTextFont(14),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.scaleWidth(20),
                  right: SizeConfig.scaleWidth(20),
                  top: SizeConfig.scaleWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "My Business",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(16),
                              color: Color(0xffCBB523),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        Text(
                          "15",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(21),
                              color: Color(0xff4C5175),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(30),
                    ),
                    Column(
                      children: [
                        Text(
                          "Completed Tasks",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(16),
                              color: Color(0xffCBB523),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(21),
                              color: Color(0xff4C5175),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(30),
                    ),
                    Column(
                      children: [
                        Text(
                          "Requests",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(16),
                              color: Color(0xffCBB523),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        Text(
                          "25",
                          style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(21),
                              color: Color(0xff4C5175),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
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
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Username:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: "Sohib Naser Khalaf",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  SizedBox(
                                    height: 50,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: "sohibnkhalaf@gmail.com",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Old password",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.scaleTextFont(
                                                        12),
                                                color: Color(0xff4C5175),
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(122),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            " New password",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.scaleTextFont(
                                                        12),
                                                color: Color(0xff4C5175),
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(50),
                                        width: SizeConfig.scaleWidth(160),
                                        child: TextField(
                                          obscureText: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.visibility_off_outlined,
                                              size: SizeConfig.scaleWidth(17),
                                              color: Color(0xffCBB523),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xffFAFAFA),
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 0,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(20),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(50),
                                        width: SizeConfig.scaleWidth(160),
                                        child: TextField(
                                          obscureText: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.visibility_off_outlined,
                                              size: SizeConfig.scaleWidth(17),
                                              color: Color(0xffCBB523),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xffFAFAFA),
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 0,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(50),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: "24",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(50),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: "0597768136",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(15),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Specialization:",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.scaleTextFont(12),
                                            color: Color(0xff4C5175),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(10),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(50),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: "Web Programmer",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(260),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      maxLines: 8,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText:
                                            "Excepteur sint occaecat cupidatat non proident,"
                                            " sunt in culpa qui officia deserunt mollit anim id est eopksio laborum. "
                                            "Sed ut perspiciatis unde omnis istpoe natus error sit"
                                            " voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, "
                                            "eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae "
                                            "dicta sunot explicabo. Nemo ernim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sedopk quia consequuntur magni dolores eos qui rationesopl voluptatem sequi nesciunt. Neque porro quisquameo est, qui dolorem ipsum quia dolor sit amet, eopsmiep consectetur, adipisci velit, seisud quia non numquam eius modi tempora incidunt ut labore et dolore wopeir magnam aliquam quaerat voluptatem eoplmuriquisqu",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.scaleTextFont(13),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  Container(
                                    height: SizeConfig.scaleHeight(60),
                                    width: SizeConfig.scaleWidth(320),
                                    // margin: EdgeInsetsDirectional.only(start:SizeConfig.scaleWidth(250)),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xff4C5175),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: TextStyleWidget(
                                            "Save ",
                                            Colors.white,
                                            SizeConfig.scaleTextFont(20),
                                            FontWeight.w500)),
                                  ),
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.check_rounded,
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
