import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/model/Notification.dart';

import '../controller/FirebaseFireStoreHelper.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationClass> notificationList = [];
  bool isLoading = false;

  Future getNotificationList() async {
    isLoading = true;
    notifyListeners();
    notificationList =
        await FirebaseFireStoreHelper.instance.getNotifications();

    isLoading = false;
    notifyListeners();
    return notificationList;
  }
}
