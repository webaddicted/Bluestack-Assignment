class ValidationHelper {

  static String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return "User name is Required";
    } else if (value.length < 3) {
      return "User name must grater then 3 digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required";
    } else if (value.length < 3) {
      return "Password must grater then 3 digits";
    }
    return null;
  }
}
