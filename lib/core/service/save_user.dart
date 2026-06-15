import 'package:dailycore/core/util/app_instance.dart';
import 'package:dailycore/data/model/user_model.dart';

class SaveUser {
  final _box = AppInstance.box;
  static const String userKey = "user";

  // save user
  Future<void> saveUser(UserModel user) async {
    await _box.write(userKey, user.toJson());
  }

  // get user
  UserModel? getUser() {

    try{
      final data = _box.read(userKey);
      if(data != null){
        return UserModel.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e){
      print("error reading user from storage: $e");
    }

    return null;
  }

  Future<void> clearUser() async {
    await _box.remove(userKey);
  }

  bool isLogginIn(){
    return _box.hasData(userKey);
  }

}