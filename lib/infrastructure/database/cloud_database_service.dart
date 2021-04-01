import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/ceo_models.dart';

class CloudDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get All entries
  // Stream<List<CEO>> getAllCeos(int limit) {
  //   return _db.collection('ceo').limit(limit).snapshots().map(
  //       (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  // }

  // //Get top 3 entries
  // Stream<List<CEO>> getThreeTopCeos() {
  //   return _db.collection('ceo').orderBy('upvotes').limit(3).snapshots().map(
  //       (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  // }

  //Get all entries in ascending order
  static Stream<List<CEO>> getTopCeos(int limit) {
    return _db
        .collection('ceo')
        .orderBy('upvotes')
        .limit(limit)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }
}
