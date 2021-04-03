import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ceo_models.dart';

class CloudDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get all entries in ascending order
  static Stream<List<CEO>> getAllCeos({int limit}) {
    final Query q = _db.collection('ceo').orderBy('upvotes', descending: true);

    if (limit == null) {
      return q.snapshots().map(
          (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
    }

    return q.limit(limit).snapshots().map(
        (event) => event.docs.map((doc) => CEO.fromMap(doc.data())).toList());
  }

  static Future<void> addUserToList(User user) async {
    bool isUserAvailable = await _checkUserDocs(user.uid);
    Map<String, dynamic> userInfo = {
      'uid': user.uid,
      'name': user.displayName,
      'imgUrl': user.photoURL,
      'ceoVisited': [] as List<String>
    };
    if (!isUserAvailable) _db.collection('users').doc(user.uid).set(userInfo);
  }

  static Future<bool> _checkUserDocs(String id) {
    return _db
        .collection('users')
        .doc(id)
        .get()
        .then((docSnapshot) => docSnapshot.exists);
  }

  static Future<List<String>> getUnvisitedCEOs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map user = json.decode(prefs.getString('cUser'));
    List<String> ceoVisited = await _db
        .collection('users')
        .doc(user['uid'])
        .get()
        .then((value) => value.get('ceoVisited'));

    QuerySnapshot snapshot = await _db.collection('ceo').get();
    List<String> allCEOs = [];
    snapshot.docs.forEach((doc) => allCEOs.add(doc.id));
    List<String> toVisitCEO = allCEOs;
    toVisitCEO.removeWhere((id) => ceoVisited.contains(id));
    print(toVisitCEO);
    return toVisitCEO;
  }
}
