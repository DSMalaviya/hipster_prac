import 'package:get/get.dart';

class ValidationContants {
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter password";
    } else if (value.trim().length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    } else if (!GetUtils.isEmail(value)) {
      return "Please enter valid email";
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter name";
    } else if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }
}
