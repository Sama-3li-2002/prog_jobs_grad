import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:uuid/uuid.dart';

import '../model/CompanyModel.dart';
import '../model/UsersModel.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();

  Uuid uuid = Uuid();
  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Programmers";
  static final String companyCollection = "Company";
  final String jobsCollection = "jobs";
  final String SubmittedjobCollection = "Submitted Job";

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
  Future create(String ComId, Jobs jobs) async {
    String job_id = uuid.v4();
    jobs.job_id = job_id;
    DocumentReference documentReference = firestore
        .collection(companyCollection)
        .doc(ComId)
        .collection(jobsCollection)
        .doc(job_id);

    await documentReference.set(jobs.toMap());

    print("ID: ${documentReference.id}");
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
  Future<DocumentSnapshot<Map<String, dynamic>>> getComInfoById(
      String id) async {
    final DocumentSnapshot<Map<String, dynamic>> comInfoSnapshot =
        await firestore.collection(companyCollection).doc(id).get();
    print("com Info $comInfoSnapshot");
    return comInfoSnapshot;
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
}
