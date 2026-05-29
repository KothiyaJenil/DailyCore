import 'dart:convert';

import 'package:dailycore/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUser {
  static const String userKey = 'user';

  Future<void> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();

    final jsonData = jsonEncode(user.toJson());

    await pref.setString(userKey, jsonData);
  }

  Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();

    final jsonString = pref.getString(userKey);

    if(jsonString == null) {
      return null;
    }

    final json = jsonDecode(jsonString);
    return UserModel.fromJson(json);
  }

  Future<void> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(userKey);
  }
}