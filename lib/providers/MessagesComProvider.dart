import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/Message.dart';

import '../controller/FirebaseAuthController.dart';
import '../model/JobsModel.dart';

class MessagesComProvider extends ChangeNotifier {

  List<Message> messagesList = [];
  Future getAllMessagesComObjects() async {
    List<Message> newMessagesList = [];
    final QuerySnapshot snapshot = await FirebaseFireStoreHelper.instance.getAllMessagesCom(
        FirebaseAuthController.fireAuthHelper.userId());
    print("the length of docs: ${snapshot.docs.length}");
    newMessagesList.clear();

    for (var element in snapshot.docs) {
      newMessagesList.add(Message.fromMap(element.data() as Map<String, dynamic>));
      print("message List is : ${newMessagesList}");
    }

    messagesList = newMessagesList;
    notifyListeners();
  }

}
