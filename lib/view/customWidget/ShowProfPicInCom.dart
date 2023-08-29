import 'package:flutter/material.dart';
import '../../controller/FirebaseFireStoreHelper.dart';
import '../../model/UsersModel.dart';

class ShowProfPicInCom extends StatefulWidget {
  String ProgId;

  ShowProfPicInCom({required this.ProgId});

  @override
  State<ShowProfPicInCom> createState() => _ShowProfPicInComState();
}

class _ShowProfPicInComState extends State<ShowProfPicInCom> {
  FirebaseFireStoreHelper fireStoreHelper =
      FirebaseFireStoreHelper.fireStoreHelper;
  Users? users;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final userResult = await fireStoreHelper.getUserData(widget.ProgId);
    setState(() {
      users = userResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return users == null
        ? CircularProgressIndicator()
        : users!.showProfPic!
            ? _buildProfileImage()
            : _buildDefaultImage();
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
