import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/model/Request.dart';

class RequestStatusProvider extends ChangeNotifier {
  List<Request> submittedJobs = [];
  Jobs jobs = Jobs.main();

  Future<List<Request>> getSubmittedJobsForUser(String userId) async {
    QuerySnapshot<Map<String, dynamic>> submittedJobsSnapshot =
        await FirebaseFirestore.instance
            .collectionGroup("Submitted Job")
            .where('ProgId', isEqualTo: userId)
            .get();

    submittedJobsSnapshot.docs.forEach((doc) {
      submittedJobs.add(Request.fromJson(doc.data()));
    });

    notifyListeners();
    return submittedJobs;
  }

  Future<Jobs> getJobInfo(String jobId, String comId) async {
    jobs =
        await FirebaseFireStoreHelper.instance.getRequestJobInfo(jobId, comId);

    notifyListeners();
    return jobs;
  }
}
