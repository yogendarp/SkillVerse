import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> createNotification({
    required String userId,
    required String title,
    required String message,
  }) async {

    await _firestore
        .collection("notifications")
        .add({

      "userId": userId,
      "title": title,
      "message": message,
      "isRead": false,
      "createdAt":
      FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getNotifications(
      String userId) {

    return _firestore
        .collection("notifications")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .snapshots();
  }
}