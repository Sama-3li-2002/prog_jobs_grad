import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/Request.dart';

class NumberOfRequestsProvider extends ChangeNotifier {
  List<Request> submittedRequests = [];
  bool isLoading = false;


  Future<List<Request>> getSubmittedRequests(String jobId) async {
    isLoading = true;
    notifyListeners();
    submittedRequests = await FirebaseFireStoreHelper.instance
        .getSubmittedRequestsForJob(jobId);

    isLoading = false;
    notifyListeners();
    return submittedRequests;
  }
}
