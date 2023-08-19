import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';

import '../model/CompanyModel.dart';
import '../model/UsersModel.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();

  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Programmers";
  static final String companyCollection = "Company";
  final String jobsCollection = "jobs";


  static FirebaseFireStoreHelper get instance{
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
      "imagUrl": users.imageUrl,
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
  Future<void> create(String id ,Jobs jobs)async{
    DocumentReference documentReference=await firestore.collection(companyCollection).doc(id).collection(jobsCollection).add(jobs.toMap());
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
  Future<QuerySnapshot<Map<String, dynamic>>> getAllCompanyJobsById() async {
    final QuerySnapshot<Map<String, dynamic>> allJobs =
    await firestore.collection(companyCollection).doc(FirebaseAuthController.fireAuthHelper.userId()).collection(jobsCollection).get();
    return allJobs;
  }

  // استرجاع كل وظائف الشركات
  Future<List<QueryDocumentSnapshot>> getAllJobsFromAllCompanies() async {
    List<QueryDocumentSnapshot> allJobsFromAllCompanies = [];

    try {
      QuerySnapshot allCompanies = await FirebaseFirestore.instance.collection(companyCollection).get();

      for (QueryDocumentSnapshot companyDoc in allCompanies.docs) {
        QuerySnapshot companyJobs = await companyDoc.reference.collection(jobsCollection).get();
        allJobsFromAllCompanies.addAll(companyJobs.docs);
      }

      return allJobsFromAllCompanies;
    } catch (e) {
      print("Firestore Error: $e");
      return [];
    }
  }

  // استرجاع بيانات البروفايل الخاص بالشركة بناء على ال ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getComInfoById() async {
    final DocumentSnapshot<Map<String, dynamic>> comInfoSnapshot =
    await firestore.collection(companyCollection).doc(FirebaseAuthController.fireAuthHelper.userId()).get();
    print("com Info $comInfoSnapshot");
    return comInfoSnapshot;
  }

}
