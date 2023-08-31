import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/model/Message.dart';

import '../model/CompanyModel.dart';
import '../model/Request.dart';
import '../model/UsersModel.dart';
import 'FirebaseAuthController.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();

  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Programmers";
  static final  String companyCollection = "Company";
  final String jobsCollection = "jobs";
  final String SubmittedjobCollection = "Submitted Job";
  final String FavoriteJobsCollection = "Favorite Jobs";
  final String archiveCollection = "Archive Job";

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
      "showProfPic": users.showProfPic,
    });
  }

  // لحفظ بيانات الشركة من الساين اب
  Future saveCompanyData(Company company, String id) async {
    await firestore.collection(companyCollection).doc(id).set({
      "id": id,
      "companyName": company.companyName,
      "email": company.email,
      "phone": company.phone,
      "address": company.address,
      "managerName": company.managerName,
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

  Future SaveProgInfoForSubmittedJob(Request request, String ProgId, String fileUrl,) async {
    firestore
        .collection(companyCollection)
        .doc(request.ComId)
        .collection(jobsCollection)
        .doc(request.JobId)
        .collection(SubmittedjobCollection)
        .doc()
        .set({
      "ProgId": ProgId,
      "ComId": request.ComId,
      "JobId": request.JobId,
      "fullName": request.fullName,
      "email": request.email,
      "city": request.city,
      "university": request.university,
      "specialization": request.specialization,
      "skills": request.skills,
      "fileUrl": fileUrl,
      "uploadedFileName": request.uploadedFileName,
      "current_date": request.current_date,
      "current_time": request.current_time,
      "status": request.status,
    });
  }

  Future<void> addToFavorites(String userId, String jobId, String comId) async {
    await firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .add({'jobId': jobId, 'comId': comId});
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

  // لتخزين الوظائف المؤرشفة
  Future<DocumentReference> createArchiveJob(Jobs jobs) async {
    DocumentReference? documentReference;
    try {
      final userUid = FirebaseAuthController.fireAuthHelper.userId();
      final companyDocRef =
          firestore.collection(companyCollection).doc(userUid);

      documentReference =
          await companyDocRef.collection(archiveCollection).add(jobs.toMap());
      print("Job archive created successfully.");
    } catch (error) {
      print("Error Job archive : $error");
    }
    return documentReference!;
  }
  // لحدذ حساب المبمرج او الشركة
  void deleteDocument(String jobsId) {
    FirebaseFirestore.instance
        .collection(companyCollection)
        .doc(FirebaseAuthController.fireAuthHelper.userId())
        .collection(jobsCollection)
        .doc(jobsId)
        .delete();
  }

  // لاسترجاع كل الوظائف المؤرشفة
  Future<List<QueryDocumentSnapshot>> getArchiveJobs() async {
    List<QueryDocumentSnapshot> allArchive = [];
    final QuerySnapshot ArchiveJobs = await firestore
        .collection(companyCollection)
        .doc(FirebaseAuthController.fireAuthHelper.userId())
        .collection(archiveCollection)
        .get();
    allArchive.addAll(ArchiveJobs.docs);
    return allArchive;
  }

  Future<List<Request>> getSubmittedRequestsForJob(String jobId) async {
    List<Request> submittedRequests = [];

    QuerySnapshot<Map<String, dynamic>> submittedRequestsSnapshot =
        await firestore
            .collection(companyCollection)
            .doc(FirebaseAuthController.fireAuthHelper.userId())
            .collection(jobsCollection)
            .doc(jobId)
            .collection(SubmittedjobCollection)
            .get();

    submittedRequestsSnapshot.docs.forEach((doc) {
      submittedRequests.add(Request.fromJson(doc.data()));
    });
    return submittedRequests;
  }

  Future<String> getUserImage(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await firestore.collection(userCollection).doc(userId).get();

    if (userSnapshot.exists) {
      String imageUrl = userSnapshot.data()!['imageUrl'];
      return imageUrl;
    } else {
      return '';
    }
  }

  Future<Jobs> getRequestJobInfo(String jobId, String comId) async {
    DocumentSnapshot<Map<String, dynamic>> jobRequestInfoSnapshot =
        await firestore
            .collection(companyCollection)
            .doc(comId)
            .collection(jobsCollection)
            .doc(jobId)
            .get();

    if (jobRequestInfoSnapshot.exists) {
      Jobs job = Jobs.fromMap(jobRequestInfoSnapshot.data()!);
      return job;
    } else {
      return Jobs.main();
    }
  }

  Future<void> updateRequest(String JobId, String ProgId, String status) async {
    QuerySnapshot<Map<String, dynamic>> submittedJobsSnapshot = await firestore
        .collection(companyCollection)
        .doc(FirebaseAuthController.fireAuthHelper.userId())
        .collection(jobsCollection)
        .doc(JobId)
        .collection(SubmittedjobCollection)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in submittedJobsSnapshot.docs) {
      if (docSnapshot.data() != null) {
        Map<String, dynamic> data = docSnapshot.data();
        if (data['ProgId'] == ProgId) {
          DocumentReference docRef = firestore
              .collection(companyCollection)
              .doc(FirebaseAuthController.fireAuthHelper.userId())
              .collection(jobsCollection)
              .doc(JobId)
              .collection(SubmittedjobCollection)
              .doc(docSnapshot.id);

          await docRef.update({
            'status': status,
          });
        }
      }
    }
  }

  Future deleteProgData(String userId) async {
    QuerySnapshot<Map<String, dynamic>> submittedJobsSnapshot = await firestore
        .collectionGroup(SubmittedjobCollection)
        .where('ProgId', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in submittedJobsSnapshot.docs) {
      await docSnapshot.reference.delete();
    }

    QuerySnapshot<Map<String, dynamic>> favoriteJobsSnapshot = await firestore
        .collection(userCollection)
        .doc(userId)
        .collection(FavoriteJobsCollection)
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in favoriteJobsSnapshot.docs) {
      await docSnapshot.reference.delete();
    }
    await firestore.collection(userCollection).doc(userId).delete();

    print("Programmer data deleted successfully");
  }

  Future deleteComData(String comId) async {
    QuerySnapshot<Map<String, dynamic>> favoriteJobsSnapshot = await firestore
        .collectionGroup(FavoriteJobsCollection)
        .where('comId', isEqualTo: comId)
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in favoriteJobsSnapshot.docs) {
      await docSnapshot.reference.delete();
    }

    QuerySnapshot<Map<String, dynamic>> archiveJobsSnapshot = await firestore
        .collection(companyCollection)
        .doc(comId)
        .collection(archiveCollection)
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in archiveJobsSnapshot.docs) {
      await docSnapshot.reference.delete();
    }

    QuerySnapshot<Map<String, dynamic>> comJobsSnapshot = await firestore
        .collection(companyCollection)
        .doc(comId)
        .collection(jobsCollection)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in comJobsSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> subJobsSnapshot =
          await docSnapshot.reference.collection(SubmittedjobCollection).get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot2
          in subJobsSnapshot.docs) {
        await docSnapshot2.reference.delete();
      }

      await docSnapshot.reference.delete();
    }

    await firestore.collection(companyCollection).doc(comId).delete();

    print("Company data deleted successfully");
  }



  // For converstation---------------------------------------------------------------------------------------


// لارسال الرسائل من المبرمج
  Future<void> sendMessageToCompany(String companyId, Message message) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(companyCollection);
    String programmerId = FirebaseAuthController.fireAuthHelper.userId();

    await collection
        .doc(companyId)
        .collection('programmers')
        .doc(programmerId)
        .collection('messages')
        .add({
      "messageContent": message.content,
    });
  }


//-------------------------------------------------------------------------------

}
