  import 'package:dailycore/core/util/app_instance.dart';
import 'package:dailycore/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final _firebaseAuth = AppInstance.firebaseAuth;
  final _firebaseFirestore = AppInstance.firebaseFirestore;

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
        createdAt: DateTime.now(),
        updatedAt: null,
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
      debugPrint(e.message);
      throw Exception(e.message);
    }
  }

  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if(credential.user == null){
        throw Exception("user not found");
      }

      final snapshot = await _firebaseFirestore
          .collection("user")
          .doc(credential.user!.uid)
          .get();

      if(!snapshot.exists || snapshot.data() == null){
        throw Exception("user not found");
      }
      final user = UserModel.fromJson(snapshot.data()!);


      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential" || e.code == "user-not-found" || e.code == "wrong-password") {
        throw Exception("Invalid email or password");
      } else if(e.code == "too-many-requests"){
        throw Exception("too many attempts. Please try again later");
      }
      debugPrint("Firebase Auth Error: ${e.message}");
      throw Exception("Login Failed");
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("An unexpected error occurred");
    }
  }

  // logout user
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }
}
