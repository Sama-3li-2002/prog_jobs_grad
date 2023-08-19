import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';

import '../model/CompanyModel.dart';
import '../model/JobsModel.dart';

class ComInfoProvider extends ChangeNotifier {
  List<Company> comInfoList =[];

  Future getComInfoObjects() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFireStoreHelper.instance.getComInfoById(FirebaseAuthController.fireAuthHelper.userId());
    comInfoList.clear();
    if (snapshot.exists) {
      comInfoList.add(Company.fromMap(snapshot.data()!));
    }
    notifyListeners();
  }
}