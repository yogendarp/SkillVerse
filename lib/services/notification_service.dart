import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
  }) async {

    await _firestore
        .collection("notifications")
        .add({
      "userId": userId,
      "title": title,
      "message": message,
      "type": type,
      "createdAt": Timestamp.now(),
      "isRead": false,
    });
  }

  Stream<QuerySnapshot> getNotifications(String userId) {

    return _firestore
        .collection("notifications")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }

  Stream<QuerySnapshot> getUnreadNotifications(String userId) {

    return _firestore
        .collection("notifications")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .where(
      "isRead",
      isEqualTo: false,
    )
        .snapshots();
  }

  Future<void> markAllAsRead(String userId) async {

    final docs = await _firestore
        .collection("notifications")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .where(
      "isRead",
      isEqualTo: false,
    )
        .get();

    for (final doc in docs.docs) {
      await doc.reference.update({
        "isRead": true,
      });
    }
  }
}