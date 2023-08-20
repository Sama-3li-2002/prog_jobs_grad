import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/UserSettings.dart';

import '../../controller/FirebaseAuthController.dart';
import '../../controller/FirebaseFireStoreHelper.dart';
import '../../model/UsersModel.dart';

class ProfWidget extends StatefulWidget {
  @override
  State<ProfWidget> createState() => _ProfWidgetState();
}

class _ProfWidgetState extends State<ProfWidget> {
  String id = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;
  Users? users;
  bool showProfPic = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      getUser();
      getSetProfPicSetting();
    });
  }

  Future<void> getUser() async {
    final userResult = await fireStoreHelper.getUserData(id);
    setState(() {
      users = userResult;
    });
  }

  Future<void> getSetProfPicSetting() async {
    showProfPic = await UserSettings.getSetting('$id-showProfPic');
  }

  @override
  Widget build(BuildContext context) {
    return showProfPic ? _buildProfileImage() : _buildDefaultImage();
  }

  Widget _buildProfileImage() {
    if (users!.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(users!.imageUrl),
      );
    } else {
      return CircleAvatar(
        child: Icon(Icons.person),
      );
    }
  }

  Widget _buildDefaultImage() {
    return CircleAvatar(
      foregroundImage: AssetImage(
        'assets/images/withoutImagePerson.jpg',
      ),
    );
  }
}
