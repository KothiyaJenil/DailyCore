import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      // Convert to ISO8601 String so GetStorage/jsonEncode can handle it
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? '',
      email: json["email"] ?? '',
      username: json["username"] ?? '',
      createdAt: _parseDateTime(json["createdAt"]),
      updatedAt: _parseDateTime(json["updatedAt"]),
    );
  }

  static DateTime? _parseDateTime(dynamic date) {
    if (date == null) return null;
    if (date is Timestamp) return date.toDate(); // From Firestore
    if (date is String) return DateTime.tryParse(date); // From GetStorage
    if (date is DateTime) return date;
    return null;
  }
}
