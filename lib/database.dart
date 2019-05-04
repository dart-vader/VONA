import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addUser {

  bool checkData() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(userData) async {
    if (checkData()) {
      Firestore.instance.collection('/users').add(userData);


    }
  }
}