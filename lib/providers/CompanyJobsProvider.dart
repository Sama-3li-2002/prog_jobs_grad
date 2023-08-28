import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';

import '../controller/FirebaseAuthController.dart';
import '../model/JobsModel.dart';

class CompanyJobsProvider extends ChangeNotifier {
  List<Jobs> JobsList = [];
  bool isLoading = false;

  Future getAllJobsObjects() async {
    isLoading = true;
    notifyListeners();
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFireStoreHelper.instance.getAllCompanyJobsById(
            FirebaseAuthController.fireAuthHelper.userId());
    JobsList.clear();
    for (var element in snapshot.docs) {
      JobsList.add(Jobs.fromMap(element.data()));
    }
    isLoading = false;
    notifyListeners();
  }
}
