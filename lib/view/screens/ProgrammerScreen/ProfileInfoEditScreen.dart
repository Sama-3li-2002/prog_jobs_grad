import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';

import '../../../controller/FirebaseAuthController.dart';
import '../../../controller/FirebaseFireStoreHelper.dart';
import '../../../model/UsersModel.dart';
import '../../../utils/size_config.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileInfoEdit extends StatefulWidget {
  static const String id = "profile_info_edit_screen";

  @override
  State<ProfileInfoEdit> createState() => _ProfileInfoEditState();
}

class _ProfileInfoEditState extends State<ProfileInfoEdit> {
  TextEditingController? _usernameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;
  TextEditingController? _specializationController;
  TextEditingController? _aboutController;

  PickedFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Reference? _storageReference;
  String? downloadUrl;
  String id = FirebaseAuthController.fireAuthHelper.userId();

  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;

  Users? users;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _ageController = TextEditingController();
    _specializationController = TextEditingController();
    _aboutController = TextEditingController();

    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController!.dispose();
    _emailController!.dispose();
    _phoneController!.dispose();
    _ageController!.dispose();
    _specializationController!.dispose();
    _aboutController!.dispose();
  }

  Future getUser() async {
    final userResult = await fireStoreHelper.getUserData(id);
    setState(() {
      users = userResult;
    });
    if (users!.username!.isNotEmpty)
      _usernameController!.text = users!.username!;
    else
      _usernameController!.text = "";
    if (users!.email!.isNotEmpty)
      _emailController!.text = users!.email!;
    else
      _emailController!.text = "";
    if (users!.phone!.isNotEmpty)
      _phoneController!.text = users!.phone!;
    else
      _phoneController!.text = "";
    if (users!.age!.toString().isNotEmpty)
      _ageController!.text = users!.age!.toString();
    else
      _ageController!.text = "";
    if (users!.specialization!.isNotEmpty)
      _specializationController!.text = users!.specialization!;
    else
      _specializationController!.text = "";
    if (users!.about!.isNotEmpty)
      _aboutController!.text = users!.about!;
    else
      _aboutController!.text = "";
  }

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
            size: SizeConfig.scaleWidth(20),
          ),
          color: Color(0xff4C5175),
        ),
        elevation: 0,
      ),
      body: users == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: CircleBorder(),
                          color: Color(0xffcbb523),
                          child: SizedBox(
                            width: SizeConfig.scaleWidth(150),
                            height: SizeConfig.scaleHeight(150),
                            child: ClipOval(
                              child: CircleAvatar(
                                backgroundImage: users!.imageUrl != null
                                    ? NetworkImage(users!.imageUrl!)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: SizeConfig.scaleHeight(12),
                          right: SizeConfig.scaleWidth(15),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey[400]!,
                                width: 1.5,
                              ),
                            ),
                            child: FloatingActionButton(
                                backgroundColor: Colors.grey.shade200,
                                foregroundColor: Colors.grey,
                                onPressed: () {
                                  _pickImage();
                                },
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xff4C5175),
                                  size: SizeConfig.scaleWidth(16),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.scaleHeight(15),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: TextField(
                                            controller: _usernameController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: TextField(
                                            controller: _emailController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                                          height: SizeConfig.scaleHeight(10),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(50),
                                          child: TextField(
                                            controller: _ageController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(50),
                                          child: TextField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(50),
                                          child: TextField(
                                            controller:
                                                _specializationController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                  color: Color(0xff4C5175),
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(10),
                                        ),
                                        SizedBox(
                                          child: TextField(
                                            controller: _aboutController,
                                            keyboardType: TextInputType.text,
                                            minLines: 2,
                                            maxLines: 8,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFAFAFA),
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
                              width: SizeConfig.scaleWidth(65),
                              height: SizeConfig.scaleHeight(65),
                              child: CircleAvatar(
                                backgroundColor: Color(0xff4C5175),
                                radius: 50,
                                child: IconButton(
                                  onPressed: () {
                                    updateUserProfile();
                                  },
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

  Future updateUserProfile() async {
    try {
      users!.id = id;
      users!.username = _usernameController!.text;
      users!.email = _emailController!.text;
      users!.age = int.tryParse(_ageController!.text);
      users!.phone = _phoneController!.text;
      users!.specialization = _specializationController!.text;
      users!.about = _aboutController!.text;

      await fireStoreHelper.SaveUserData(users!, id);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return ProfileInfo(FirebaseAuthController.fireAuthHelper.userId());
      }));
    } catch (error) {
      print("Error updating user profile: $error");
    }
  }

  Future _pickImage() async {
    _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        _storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        _storageReference!
            .putFile(File(_pickedImage!.path))
            .then((taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((downloadUrl) {
            setState(() {
              users!.imageUrl = downloadUrl;
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
