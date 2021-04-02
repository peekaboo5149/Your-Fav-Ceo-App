import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/ceo_models.dart';

class CloudDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get all entries in ascending order
  static Stream<List<CEO>> getTopCeos(int limit) {
    return _db
        .collection('ceo')
        .orderBy('upvotes', descending: true)
        .limit(limit)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }

  static likeAndReturnCeo(User user) {}
}
