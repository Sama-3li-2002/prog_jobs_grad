import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import '../model/JobsModel.dart';

class ArchiveProvider extends ChangeNotifier {
  List<Jobs> archiveList = [];

  Future<void> getArchiveJobsObjects() async {
    List<Jobs> newArchiveList = [];
    // List<QueryDocumentSnapshot> allArchives =
    //     await FirebaseFireStoreHelper.instance.getArchiveJobs();

    // for (var element in allArchives) {
    //   newArchiveList.add(Jobs.fromMap(element.data() as Map<String, dynamic>));
  }

  // archiveList = newArchiveList;
  notifyListeners();
// }
}
