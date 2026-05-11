class Validators {

  static String? validateEmpty(
    String value,
    String fieldName,
  ) {

    if (value.trim().isEmpty) {
      return "$fieldName is required";
    }

    return null;
  }

  static String? validateEmail(
    String value,
  ) {

    if (value.trim().isEmpty) {
      return "Email is required";
    }

    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(value)) {

      return "Enter valid email";
    }

    return null;
  }

  static String? validatePassword(
    String value,
  ) {

    if (value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Minimum 6 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "At least 1 uppercase letter";
    }

    if (!RegExp(
      r'[!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(value)) {

      return "At least 1 special character";
    }

    return null;
  }

  static String? validateConfirmPassword(
    String value,
    String originalPassword,
  ) {

    if (value != originalPassword) {
      return "Passwords do not match";
    }

    return null;
  }
}