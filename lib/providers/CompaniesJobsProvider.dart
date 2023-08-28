import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';

import '../model/JobsModel.dart';

class CompaniesJobsProvider extends ChangeNotifier {
  List<Jobs> JobsList = [];
  bool isLoading = false;

  Future<void> getAllJobsObjects() async {
    isLoading = true;
    notifyListeners();
    List<Jobs> jobsList = [];
    List<QueryDocumentSnapshot> allJobs =
        await FirebaseFireStoreHelper.instance.getAllJobsFromAllCompanies();

    for (var element in allJobs) {
      jobsList.add(Jobs.fromMap(element.data() as Map<String, dynamic>));
    }

    JobsList = jobsList;
    isLoading = false;
    notifyListeners();
  }
}
