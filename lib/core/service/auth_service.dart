import 'package:dailycore/core/util/firebase_instance.dart';
import 'package:dailycore/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final _firebaseAuth = FirebaseInstance.firebaseAuth;
  final _firebaseFirestore = FirebaseInstance.firebaseFirestore;

  Future<UserModel> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        username: username,
        email: email,
      );

      await _firebaseFirestore
          .collection("user")
          .doc(user.uid)
          .set(user.toJson());

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw Exception("Email already exists");
      }
      throw Exception(e.message);
    }
  }

  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final snapshot = await _firebaseFirestore
          .collection("user")
          .doc(credential.user!.uid)
          .get();

      final user = UserModel.fromJson(snapshot.data()!);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        throw Exception("Invalid email or password");
      }
      throw Exception("Login Failed");
    }
  }

  // logout user
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }
}
