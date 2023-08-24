import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';

import '../model/CompanyModel.dart';
import '../model/UsersModel.dart';
import 'FirebaseAuthController.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();

  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Programmers";
  static final String companyCollection = "Company";
  final String jobsCollection = "jobs";
  final String SubmittedjobCollection = "Submitted Job";
  final String FavoriteJobsCollection = "Favorite Jobs";

  static FirebaseFireStoreHelper get instance {
    return fireStoreHelper;
  }

// لحفظ بيانات المبرمج من واجهة الساين اب
  Future SaveUserData(Users users, String id) async {
    await firestore.collection(userCollection).doc(id).set({
      "id": id,
      "email": users.email,
      "username": users.username,
      "phone": users.phone,
      "age": users.age,
      "specialization": users.specialization,
      "about": users.about,
      "imageUrl": users.imageUrl,
    });
  }

  // لحفظ بيانات الشركة من الساين اب
  Future saveCompanyData(Company company, String id) async {
    await firestore.collection(companyCollection).doc(id).set({
      "id": id,
      "companyName": company.companyName,
      "email": company.email,
      "password": company.password,
      "phone": company.phone,
      "address": company.address,
      "managerName": company.managerName,
      "facebookAccount": company.facebookAccount,
      "twitterAccount": company.twitterAccount,
      "instagramAccount": company.InstagramAccount,
      "about": company.about,
      "image": company.image,
      "managerImage": company.managerImage,
    });
  }

  // لعمل كولكشن jobs بداخل الكولكشن تبع الشركة لاضافة وظيفة جديدة اعتمادا على ID الشركة
  Future create(Jobs jobs) async {
    DocumentReference documentReference = await firestore
        .collection(companyCollection)
        .doc(FirebaseAuthController.fireAuthHelper.userId())
        .collection(jobsCollection)
        .add(jobs.toMap());

    return documentReference;
  }

  // لاسترجاع بيانات المبرمج بناء على ال ID
  Future getUserData(String id) async {
    try {
      final data = await firestore.collection(userCollection).doc(id).get();
      final user = await Users.fromJson(data.data()!);
      return user;
    } catch (e) {
      return false;
    }
  }

  // استرجاع كل وظائف الشركة بناء على ID الخاص بها
  Future<QuerySnapshot<Map<String, dynamic>>> getAllCompanyJobsById(
      String id) async {
    final QuerySnapshot<Map<String, dynamic>> allJobs = await firestore
        .collection(companyCollection)
        .doc(id)
        .collection(jobsCollection)
        .get();
    return allJobs;
  }

  // استرجاع كل وظائف الشركات
  Future<List<QueryDocumentSnapshot>> getAllJobsFromAllCompanies() async {
    List<QueryDocumentSnapshot> allJobsFromAllCompanies = [];

    try {
      QuerySnapshot allCompanies =
          await FirebaseFirestore.instance.collection(companyCollection).get();

      for (QueryDocumentSnapshot companyDoc in allCompanies.docs) {
        QuerySnapshot companyJobs =
            await companyDoc.reference.collection(jobsCollection).get();
        allJobsFromAllCompanies.addAll(companyJobs.docs);
      }

      return allJobsFromAllCompanies;
    } catch (e) {
      print("Firestore Error: $e");
      return [];
    }
  }

  // استرجاع بيانات البروفايل الخاص بالشركة بناء على ال ID
  Future<List<Company>> getComInfoById(String id) async {
    List<Company> comInfoList = [];
    final DocumentSnapshot<Map<String, dynamic>> comInfoSnapshot =
        await firestore.collection(companyCollection).doc(id).get();
    if (comInfoSnapshot.exists) {
      comInfoList.add(Company.fromMap(comInfoSnapshot.data()!));
    }
    return comInfoList;
  }

  // لتحديث بيانات معلومات بروفايل الشركة حسب ال ID
  Future updateCompanyProfileInfo(Company company) async {
    await firestore
        .collection(companyCollection)
        .doc(FirebaseAuthController.fireAuthHelper.userId())
        .update(company.toMap());
  }

// تحديث معلومات الوظيفة
  Future<void> updateJobsDetails(Jobs jobs, String idJob) async {
    try {
      final userUid = FirebaseAuthController.fireAuthHelper.userId();
      final companyDocRef =
          firestore.collection(companyCollection).doc(userUid);
      final jobDocRef = companyDocRef.collection(jobsCollection).doc(idJob);

      final jobDataMap = jobs.toMap();

      await jobDocRef.update(jobDataMap);
      print("Job details updated successfully.");
    } catch (error) {
      print("Error updating job details: $error");
    }
  }

  Future SaveProgInfoForSubmittedJob(
    Users users,
    String ProgId,
    String ComId,
    String JobId,
    String fileUrl,
  ) async {
    firestore
        .collection(companyCollection)
        .doc(ComId)
        .collection(jobsCollection)
        .doc(JobId)
        .collection(SubmittedjobCollection)
        .doc()
        .set({
      "ProgId": ProgId,
      "ComId": ComId,
      "JobId": JobId,
      "fullName": users.fullName,
      "email": users.email,
      "city": users.city,
      "university": users.university,
      "specialization": users.specialization,
      "skills": users.skills,
      "fileUrl": fileUrl,
    });
  }

  Future<void> addToFavorites(String userId, String jobId) async {
    await firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .add({'jobId': jobId});
  }

  Future<void> removeFromFavorites(String userId, String jobId) async {
    QuerySnapshot favoritesSnapshot = await firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .where('jobId', isEqualTo: jobId)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in favoritesSnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  Future<bool> isJobFavorited(String userId, String jobId) async {
    QuerySnapshot favoritesSnapshot = await firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .where('jobId', isEqualTo: jobId)
        .get();

    bool isFavorite = favoritesSnapshot.docs.isNotEmpty;

    return isFavorite;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserFavorites(String userId) {
    return firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .get();
  }
}
