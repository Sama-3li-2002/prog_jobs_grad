import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/CompanyModel.dart';
import '../model/UsersModel.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();

  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Programmers";
  final String companyCollection = "Company";

  Future SaveUserData(Users users, String id) async {
    await firestore.collection(userCollection).doc(id).set({
      "id": id,
      "email": users.email,
      "username": users.username,
      "phone": users.phone,
      "age": users.age,
      "specialization": users.specialization,
      "about": users.about,
    });
  }

  Future saveCompanyData(Company company, String id) async {
    await firestore.collection(companyCollection).doc(id).set({
      "id": id,
      "userName": company.companyName,
      "email": company.email,
      "password": company.password,
      "phone": company.phone,
      "Address": company.address,
      "facebookAccount": company.facebookAccount,
      "twitterAccount": company.twitterAccount,
      "InstagramAccount": company.InstagramAccount,
      "about": company.about,
      "image": company.image,

    });
  }
}
