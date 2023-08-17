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
  }

  @override
  Widget build(BuildContext context) {
    getUser();
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
                    bottom: SizeConfig.scaleHeight(0),
                    right: SizeConfig.scaleWidth(10),
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
                                      controller: _usernameController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: users!.username.toString(),
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
                                      controller: _emailController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: users!.email.toString(),
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
                                      controller: _ageController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: users!.age.toString(),
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
                                      controller: _phoneController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: users!.phone.toString(),
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
                                      controller: _specializationController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText:
                                            users!.specialization.toString(),
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
                                    child: TextField(
                                      controller: _aboutController,
                                      keyboardType: TextInputType.text,
                                      minLines: 2,
                                      maxLines: 8,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffFAFAFA),
                                        hintText: users!.about.toString(),
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
                            onPressed: () {
                              uploadImage();
                              updateUserProfile();

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return ProfileInfo();
                              }));
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
      users!.imageUrl = downloadUrl;

      await fireStoreHelper.SaveUserData(users!, id);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return ProfileInfo();
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
              fireStoreHelper.SaveUserData(users!, id);
            });
          });
        });
      } else {
        print('No Image Selected');
      }
    });
  }

  Future uploadImage() async {
    if (_storageReference != null && _pickedImage != null) {
      final uploadTask = _storageReference!.putFile(File(_pickedImage!.path));
      await uploadTask.whenComplete(() {
        print('Image upload complete');
      }).then((TaskSnapshot snapshot) async {
        downloadUrl = await snapshot.ref.getDownloadURL();
        print('Download URL: $downloadUrl');

        await updateUserProfile();
        Navigator.of(context).pop();
      }).catchError((error) {
        print("Error uploading image: $error");
      });
    }
  }
}
