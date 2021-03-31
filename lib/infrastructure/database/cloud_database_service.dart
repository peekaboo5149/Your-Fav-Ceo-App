import 'package:cloud_firestore/cloud_firestore.dart';

import 'ceo.dart';

class CloudDatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get All entries
  Stream<List<CEO>> getAllCeos() {
    return _db.collection('ceo').snapshots().map(
        (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }

  //Get top 3 entries
  Stream<List<CEO>> getThreeTopCeos() {
    return _db.collection('ceo').orderBy('upvotes').limit(3).snapshots().map(
        (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }

  //Get all entries in ascending order
  Stream<List<CEO>> getTopCeos() {
    return _db.collection('ceo').orderBy('upvotes').snapshots().map(
        (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }
}
