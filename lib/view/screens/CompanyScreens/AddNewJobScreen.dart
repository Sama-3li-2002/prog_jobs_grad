import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';

import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class AddNewJobScreen extends StatefulWidget {
  static const String id = "add_new_job_screen";

  @override
  State<AddNewJobScreen> createState() => _AddNewJobScreenState();
}

class _AddNewJobScreenState extends State<AddNewJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xfffF5F5F5),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleWidget("Add new job:", Color(0xffCBB523),
                  SizeConfig.scaleTextFont(18), FontWeight.w500),
              Center(
                child: Stack(
                  children: [
                    Container(
                      // padding: EdgeInsets.all(20),
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            "assets/images/addJob.png",
                            width: SizeConfig.scaleWidth(150),
                            height: SizeConfig.scaleHeight(145),
                            fit: BoxFit.cover,
                          ),
                        ),
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
                              size: SizeConfig.scaleWidth(22),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              TextStyleWidget("job name:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget(),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Company Name:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget(),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Salary:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget(),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Company Name:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget(),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Job description:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              SizedBox(
                height: SizeConfig.scaleHeight(90),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'write...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.scaleTextFont(13),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("required skills:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              SizedBox(
                height: SizeConfig.scaleHeight(90),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'write...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.scaleTextFont(13),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(15)),
              Center(
                child: Container(
                  width: SizeConfig.scaleWidth(350),
                  height: SizeConfig.scaleHeight(48),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4C5175),
                      ),
                      child: TextStyleWidget("sharing", Color(0xffFAFAFA),
                          SizeConfig.scaleTextFont(17), FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
