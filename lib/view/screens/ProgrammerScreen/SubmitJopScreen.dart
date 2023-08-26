import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/model/Request.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/CompanyModel.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';

class SubmitJopScreen extends StatefulWidget {
  static const String id = "submit_job_screen";
  late List<Company> itemsComInfo;
  String? JobId;
  String? ComId;

  SubmitJopScreen(
      {required this.itemsComInfo, required this.ComId, required this.JobId});

  @override
  State<SubmitJopScreen> createState() => _SubmitJopScreenState();
}

class _SubmitJopScreenState extends State<SubmitJopScreen> {
  TextEditingController? _fullName;
  TextEditingController? _email;
  TextEditingController? _city;
  TextEditingController? _university;
  TextEditingController? _specialization;
  TextEditingController? _skills;

  String Progid = FirebaseAuthController.fireAuthHelper.userId();

  String uploadedFileName = '';
  String downloadUrl = '';

  late String formattedDate;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _city = TextEditingController();
    _university = TextEditingController();
    _specialization = TextEditingController();
    _skills = TextEditingController();

    // for time & date
    DateTime currentDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    formattedTime = DateFormat('hh:mm:ss a').format(currentDate);
  }

  @override
  void dispose() {
    super.dispose();
    _fullName?.dispose();
    _email?.dispose();
    _city?.dispose();
    _university?.dispose();
    _specialization?.dispose();
    _skills?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF5F5F5),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return CompanyInfo();
                            }));
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
                          Icons.location_on_sharp,
                          color: Color(0xffCBB523),
                          size: SizeConfig.scaleWidth(15),
                        ),
                        TextStyleWidget(
                            widget.itemsComInfo.isNotEmpty
                                ? widget.itemsComInfo[0].address!
                                : "No Address Available",
                            Color(0xff4C5175),
                            SizeConfig.scaleTextFont(15),
                            FontWeight.w500),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {},
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
                          TextFieldWidget.textfieldCon(
                            controller: _fullName,
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(12)),
                          TextStyleWidget("E_mail:", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          TextFieldWidget.textfieldCon(
                            controller: _email,
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(12),
                          ),
                          TextStyleWidget("City:", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          TextFieldWidget.textfieldCon(
                            controller: _city,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(12),
                          ),
                          TextStyleWidget("university:", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          TextFieldWidget.textfieldCon(
                            controller: _university,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(12),
                          ),
                          TextStyleWidget("Specialization:", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          TextFieldWidget.textfieldCon(
                            controller: _specialization,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(12),
                          ),
                          TextStyleWidget("skills:", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          SizedBox(
                            height: SizeConfig.scaleHeight(90),
                            width: SizeConfig.scaleWidth(335),
                            child: TextField(
                              controller: _skills,
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
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(12),
                          ),
                          TextStyleWidget("CV (.pdf Only):", Color(0xff4C5175),
                              SizeConfig.scaleTextFont(12), FontWeight.w500),
                          Row(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.all(SizeConfig.scaleHeight(10)),
                                height: SizeConfig.scaleHeight(48),
                                width: SizeConfig.screenWidth! * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextStyleWidget(
                                    uploadedFileName,
                                    Color(0xff4C5175),
                                    SizeConfig.scaleTextFont(20),
                                    FontWeight.normal),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    _pickFile();
                                  },
                                  icon: Icon(
                                    Icons.upload_file,
                                    color: Color(0xff4C5175),
                                  ))
                            ],
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(15)),
                          Center(
                            child: Container(
                              width: SizeConfig.scaleWidth(320),
                              height: SizeConfig.scaleHeight(48),
                              child: ElevatedButton(
                                  onPressed: () {
                                    saveProgInfoForSubmJob();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff4C5175),
                                  ),
                                  child: TextStyleWidget(
                                      "submit",
                                      Colors.white,
                                      SizeConfig.scaleTextFont(20),
                                      FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            )));
  }

  Future saveProgInfoForSubmJob() async {
    if (_fullName!.text.isNotEmpty &&
        _email!.text.isNotEmpty &&
        _city!.text.isNotEmpty &&
        _university!.text.isNotEmpty &&
        _specialization!.text.isNotEmpty &&
        _skills!.text.isNotEmpty &&
        uploadedFileName.isNotEmpty &&
        downloadUrl.length != 1) {
      Request request = Request.submitJob(
          _fullName!.text,
          _email!.text,
          _city!.text,
          uploadedFileName,
          _university!.text,
          _skills!.text,
          _specialization!.text,
          formattedTime,
          formattedDate);

      String JobId = widget.JobId!;
      String ComId = widget.ComId!;

      setState(() {});
      FirebaseFireStoreHelper.fireStoreHelper.SaveProgInfoForSubmittedJob(
          request, Progid, ComId, JobId, downloadUrl);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Please Fill All Fields",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        String filePath = file.path ?? '';
        String fileName = file.name ?? '';

        setState(() {
          uploadedFileName = fileName;
        });
        await uploadFile(filePath, fileName);
      } else {
        print('User canceled the file picker.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future uploadFile(String path, String fileName) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('Uploaded_Files').child(fileName);

    storageReference.putFile(File(path));

    setState(() async {
      downloadUrl = await storageReference.getDownloadURL();
    });
  }
}
