class Validators {
  static String? username(String? value){
    if(value == null || value.isEmpty){
      return "username is required";
    }
  }
  static String? email(String? value){
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+',);
    if(value == null || value.isEmpty){
      return "email is required";
    }
    if(!emailRegex.hasMatch(value)){
      return "enter valid email";
    }
  }
  static String? password(String? value){
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    if(value == null || value.isEmpty){
      return "email is required";
    }

    if (value.length < 6) {
      return "password must be 6 latter";
    }
    // if(!passwordRegex.hasMatch(value)){
    //   return "enter strong password";
    // }
  }
}