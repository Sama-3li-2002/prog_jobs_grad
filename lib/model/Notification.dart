import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationClass {
  String? notification_content;
  String? comId;
  String? ProgId;
  late DateTime timestamp;

  NotificationClass.fromJson(Map<String, dynamic> data) {
    notification_content = data['notification_content'];
    comId = data['comId'];
    ProgId = data['ProgId'];
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}
