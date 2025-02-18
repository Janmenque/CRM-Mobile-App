import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseRepository {
  final fireStore = FirebaseFirestore.instance;

  Future sendLocationToFirebase(userId, locationMap) async{
    return fireStore
        .collection('hrm_employee_track')
        .doc('$userId')
        .set(locationMap)
        .catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
  }
}
