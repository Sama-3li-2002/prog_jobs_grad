import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/utils/size_config.dart';
import '../../customWidget/TextFieldWidget.dart';
import '../../customWidget/textStyleWidget.dart';
import 'com_home.dart';

class AddNewJobScreen extends StatefulWidget {
  static const String id = "add_new_job_screen";

  @override
  State<AddNewJobScreen> createState() => _AddNewJobScreenState();
}

class _AddNewJobScreenState extends State<AddNewJobScreen> {
  // عدد النقرات على زر add skills
  int _clickCount = 0;

  //Dynamic Text Fields
  List<TextField> textFields = [];
  int index = 0;
  late List<TextEditingController> controllers;

  // For Image Picker
  PickedFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  Reference? _storageReference;
  String? jobImage =
      'https://firebasestorage.googleapis.com/v0/b/prog-jobs-grad.appspot.com/o/job_images%2FaddJob.png?alt=media&token=5cdcaa1f-d727-4462-a2b6-78a5813f9c81';

  TextEditingController? _job_nameTextController;
  TextEditingController? _company_nameTextController;
  TextEditingController? _salaryTextController;
  TextEditingController? _job_descriptionTextController;

  //For Controller
  late TextEditingController _controllerOneSkills;
  late TextEditingController _controllerTwoSkills;
  late TextEditingController _cotrollerThreeSkills;
  late TextEditingController _controllerFourSkills;

  late String formattedDate;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    _job_nameTextController = TextEditingController();
    _company_nameTextController = TextEditingController();
    _salaryTextController = TextEditingController();
    _job_descriptionTextController = TextEditingController();

    // For controller
    _controllerOneSkills = TextEditingController();
    _controllerTwoSkills = TextEditingController();
    _cotrollerThreeSkills = TextEditingController();
    _controllerFourSkills = TextEditingController();

    controllers = [
      _controllerTwoSkills,
      _cotrollerThreeSkills,
      _controllerFourSkills
    ];

    // for current time
    DateTime currentDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    formattedTime = DateFormat('hh:mm:ss a').format(currentDate);
  }

  @override
  void dispose() {
    super.dispose();
    _job_nameTextController?.dispose();
    _company_nameTextController?.dispose();
    _salaryTextController?.dispose();
    _job_descriptionTextController?.dispose();

    //For controller
    _controllerOneSkills?.dispose();
    _controllerTwoSkills?.dispose();
    _cotrollerThreeSkills?.dispose();
    _controllerFourSkills?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: jobImage != null
                            ? Image.network(
                                jobImage!,
                                width: SizeConfig.scaleWidth(150),
                                height: SizeConfig.scaleHeight(145),
                                fit: BoxFit.cover,
                              )
                            : Image.asset('assets/images/addJob.png'),
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
                            onPressed: () {
                              _pickImage();
                            },
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
              TextFieldWidget.textfieldCon(
                controller: _job_nameTextController,
              ),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Company Name:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget.textfieldCon(
                controller: _company_nameTextController,
              ),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Salary:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              TextFieldWidget.textfieldCon(
                controller: _salaryTextController,
              ),
              SizedBox(height: SizeConfig.scaleHeight(12)),
              TextStyleWidget("Job description:", Color(0xff4C5175),
                  SizeConfig.scaleTextFont(12), FontWeight.w500),
              SizedBox(
                height: SizeConfig.scaleHeight(90),
                child: TextField(
                  controller: _job_descriptionTextController,
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
              Row(
                children: [
                  TextStyleWidget("required skills:", Color(0xff4C5175),
                      SizeConfig.scaleTextFont(12), FontWeight.w500),
                  Spacer(),
                  Container(
                    width: SizeConfig.scaleWidth(90),
                    height: SizeConfig.scaleHeight(40),
                    child: ElevatedButton(

                      onPressed: () {
                        if (_clickCount < 4) {
                          setState(() {
                            _clickCount++;
                            textFields.add(
                              TextField(
                                controller: controllers[index],
                                // enabled: _clickCount <= 3,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'write...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: SizeConfig.scaleTextFont(13),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                              ),
                            );
                            index++;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _clickCount == 3
                              ? Colors.grey
                              : Color(0xff4C5175)),
                      child: Row(children: [
                        // Icon(Icons.add),
                        Image.asset("assets/images/add.png"),
                        SizedBox(
                          width: SizeConfig.scaleWidth(7),
                        ),
                        TextStyleWidget("Add Skils", Color(0xffFAFAFA),
                            SizeConfig.scaleTextFont(9), FontWeight.w500)
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.scaleHeight(17)),
              SizedBox(
                height: SizeConfig.scaleHeight(48),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _controllerOneSkills,
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
              Column(
                children: [
                  for (TextField textField in textFields)
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                      child: SizedBox(
                        height: SizeConfig.scaleHeight(48),
                        child: textField,
                      ),
                    ),
                ],
              ),
              SizedBox(height: SizeConfig.scaleHeight(15)),
              Center(
                child: Container(
                  width: SizeConfig.scaleWidth(350),
                  height: SizeConfig.scaleHeight(48),
                  child: ElevatedButton(
                      onPressed: () async {
                        await performStore();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ComHomeScreen();
                            },
                          ),
                        );
                      },
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

  Future performStore() async {
    if (checkData()) await store();
  }

  bool checkData() {
    if (_job_nameTextController!.text.isNotEmpty &&
        _company_nameTextController!.text.isNotEmpty &&
        _salaryTextController!.text.isNotEmpty &&
        _job_descriptionTextController!.text.isNotEmpty &&
        _controllerOneSkills!.text.isNotEmpty)
      return true;
    else
      Fluttertoast.showToast(
        msg: "can't be null",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    print("can't be null");
    return false;
  }

  Future store() async {
    DocumentReference documentReference =
        await FirebaseFireStoreHelper.instance.create(getJobs());
    String newJobId = documentReference.id;
    Jobs newJob = getJobs();
    newJob.job_id = newJobId;
    await documentReference.update({'job_id': newJobId});
    clear();
  }

  Jobs getJobs() {
    return Jobs(
      id: FirebaseAuthController.fireAuthHelper.userId(),
      job_image: jobImage,
      current_date: formattedDate,
      current_time: formattedTime,
      job_name: _job_nameTextController!.text,
      company_name: _company_nameTextController!.text,
      salary: _salaryTextController!.text,
      job_description: _job_descriptionTextController!.text,
      required_skills_one: _controllerOneSkills!.text,
      required_skills_two: controllers.elementAt(0).text,
      required_skills_three: controllers.elementAt(1).text,
      required_skills_four: controllers.elementAt(2).text,
    );
  }

  void clear() {
    _job_nameTextController!.text = "";
    _company_nameTextController!.text = "";
    _salaryTextController!.text = "";
    _job_descriptionTextController!.text = "";
    _controllerOneSkills!.text = "";
    _controllerTwoSkills!.text = "";
    _cotrollerThreeSkills!.text = "";
    _controllerFourSkills!.text = "";
  }

  Future _pickImage() async {
    _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        _storageReference = FirebaseStorage.instance
            .ref()
            .child('job_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        _storageReference!
            .putFile(File(_pickedImage!.path))
            .then((taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((downloadUrll) {
            setState(() {
              jobImage = downloadUrll;
            });
          });
        }).catchError((error) {
          print("Error uploading image: $error");
        });
      } else {
        print('No Image Selected');
      }
    });
  }
}
