import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/Request.dart';

class NumberOfRequestsProvider extends ChangeNotifier {
  List<Request> submittedRequests = [];

  Future<List<Request>> getSubmittedRequests(String jobId) async {
    submittedRequests = await FirebaseFireStoreHelper.instance
        .getSubmittedRequestsForJob(jobId);
    notifyListeners();
    return submittedRequests;
  }
}
