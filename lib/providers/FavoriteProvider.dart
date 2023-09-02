import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';

import '../model/JobsModel.dart';

class FavoriteProvider with ChangeNotifier {
  bool isLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuthController.fireAuthHelper.userId();
  FirebaseFireStoreHelper helper = FirebaseFireStoreHelper.instance;

  List<Jobs> favoriteJobsList = [];
  List favoriteJobIds = [];

  Future getFavoriteJobsForUser(String userId) async {
    isLoading = true;
    notifyListeners();
    List<Jobs> favoriteJobList = [];

    QuerySnapshot<Map<String, dynamic>> favoriteJobsSnapshot =
        await helper.getUserFavorites(userId);
    favoriteJobIds = favoriteJobsSnapshot.docs
        .map((favoriteDoc) => favoriteDoc.get('jobId'))
        .toList();

    List<QueryDocumentSnapshot> allJobs =
        await helper.getAllJobsFromAllCompanies();

    for (var jobDoc in allJobs) {
      String jobId = jobDoc.id;
      if (favoriteJobIds.contains(jobId)) {
        favoriteJobList
            .add(Jobs.fromMap(jobDoc.data() as Map<String, dynamic>));
      }
    }
    favoriteJobsList = favoriteJobList;
    isLoading = false;
    notifyListeners();
    return favoriteJobsList;
  }

  Future removeFromFavorites(String jobId) async {
    await FirebaseFireStoreHelper.instance.removeFromFavorites(
        FirebaseAuthController.fireAuthHelper.userId(), jobId);
    favoriteJobIds.remove(jobId);

    notifyListeners();
  }
}
