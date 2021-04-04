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
      'ceoVisited': [] as List<String>,
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

  static Future<void> updateUserCeoList(
      String userId, String ceoId, bool isUpvote) async {
    var ds = await _db.collection('users').doc(userId).get();
    List ceoVisited = ds.data()['ceoVisited'];
    ceoVisited.add(ceoId);
    await _db
        .collection('users')
        .doc(userId)
        .update({'ceoVisited': ceoVisited});
    ds = await _db.collection('ceo').doc(ceoId.trim()).get();
    var toChange = isUpvote ? ds.data()['upvotes'] : ds.data()['downvotes'];
    toChange++;
    isUpvote
        ? await _db
            .collection('ceo')
            .doc(ceoId.trim())
            .update({'upvotes': toChange})
        : await _db
            .collection('ceo')
            .doc(ceoId.trim())
            .update({'downvotes': toChange});
  }

  static Future<List<CEO>> getUnvisitedCEOs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map user = json.decode(prefs.getString('cUser'));
    List ceoVisited = await _db
        .collection('users')
        .doc(user['uid'])
        .get()
        .then((value) => value.get('ceoVisited'));
    // print('================');
    // ceoVisited.forEach((element) {
    //   print(element);
    // });
    // print('================');
    QuerySnapshot snapshot = await _db.collection('ceo').get();
    List<String> allCEOs = [];
    snapshot.docs.forEach((doc) => allCEOs.add(doc.id));
    List<String> temp = allCEOs;
    temp.removeWhere((id) => ceoVisited.contains(id));
    // temp.forEach((element) {
    //   print(element);
    // });
    List<CEO> toVisitCEO = [];
    for (int i = 0; i < temp.length; i++) {
      var ceoID = temp[i];
      var ds = await _db.collection('ceo').doc(ceoID).get();
      toVisitCEO.add(CEO.fromMap(ds.data()));
    }
    return toVisitCEO;
  }

  // Future<List<CEO>> getListofCeos(String id) {
  //   List<String> temp = [];

  //   return getUnvisitedCEOs().then((value) {
  //     temp = [...value];
  //     return temp
  //         .map((e) => _db
  //             .collection('ceo')
  //             .doc(e)
  //             .get()
  //             .then((value) => CEO.fromMap(value.data())))
  //         .toList();
  //   });

  //   // return _db
  //   //     .collection('ceo')
  //   //     .doc(id)
  //   //     .get()
  //   //     .then((value) => CEO.fromMap(value.data()));
  // }

}
