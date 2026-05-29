import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // create a user model for the app
  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    this.createdAt,
    this.updatedAt,
  });

  // create a user model for the firebase
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      email: json["email"],
      username: json["username"],
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      updatedAt: json["updatedAt"] != null
          ? (json["updatedAt"] as Timestamp).toDate()
          : null,
    );
  }
}
