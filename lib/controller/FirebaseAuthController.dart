import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/model/UsersModel.dart';

import 'FirebaseFireStoreHelper.dart';

class FirebaseAuthController {
  FirebaseAuthController._();

  static FirebaseAuthController fireStoreHelper = FirebaseAuthController._();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> createAccount(Users users) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: users.email!, password: users.password!);
      String id = userCredential.user!.uid;
      FirebaseFireStoreHelper.fireStoreHelper.SaveUserData(users, id);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("creatAccount:  code" + e.message!);
      if (e.code == "email-already-in-use") {
        print("creatAccount:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "email-already-in-use",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "invalid-email") {
        print("creatAccount:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "invalid-email",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "operation-not-allowed") {
        print("creatAccount:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "operation-not-allowed",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "weak-password") {
        print("creatAccount:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "weak-password",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Creat Accrount: Exception: $e");
    }

    return null;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("signIn: code" + e.code);
      if (e.code == "user-not-found") {
        print("signIn:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "user-not-found",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "invalid-email") {
        print("signIn:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "invalid-email",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "user-disabled") {
        print("signIn:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "user-disabled",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (e.code == "wrong-password") {
        print("signIn:  code" + e.message!);
        Fluttertoast.showToast(
          msg: "wrong-password",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("signIn :Exception: $e");
    }
    return null;
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future ForgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  String userId() {
    return _auth.currentUser!.uid;
  }
}
