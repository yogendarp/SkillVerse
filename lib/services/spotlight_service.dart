import 'package:cloud_firestore/cloud_firestore.dart';

class SpotlightService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSpotlight() {
    return _firestore
        .collection("showcases")
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }
}