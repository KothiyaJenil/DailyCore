class UserModel {
  final String uid;
  final String username;
  final String email;

  // create a user model for the app
  UserModel({required this.uid, required this.email, required this.username});

  // create a user model for the firebase
  Map<String, dynamic> toJson(){
    return {
      "uid": uid,
      "username": username,
      "email": email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(uid: json["uid"], email: json["email"], username: json["username"]);
  }
}