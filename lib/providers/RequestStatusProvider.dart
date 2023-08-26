import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/model/Request.dart';

class RequestStatusProvider extends ChangeNotifier {
  List<Request> submittedJobs = [];

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
}
