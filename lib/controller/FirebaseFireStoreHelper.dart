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
      "imageUrl": users.imageUrl,
    });
  }

  Future getUserData(String id) async {
    try {
      final data = await firestore.collection(userCollection).doc(id).get();
      final user = await Users.fromJson(data.data()!);
      return user;
    } catch (e) {
      return false;
    }
  }

  Future saveCompanyData(Company company, String id) async {
    await firestore.collection(companyCollection).doc(id).set({
      "id": id,
      "companyName": company.companyName,
      "email": company.email,
      "password": company.password,
      "phone": company.phone,
      "address": company.address,
      "facebookAccount": company.facebookAccount,
      "twitterAccount": company.twitterAccount,
      "instagramAccount": company.InstagramAccount,
      "about": company.about,
      "image": company.image,
    });
  }
}
