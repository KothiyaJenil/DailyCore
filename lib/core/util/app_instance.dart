import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AppInstance {

  // create a instance for the firebase auth 
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // create a instance for the firebase firestore
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // create a instance for the get storage
  static final GetStorage box = GetStorage();
}