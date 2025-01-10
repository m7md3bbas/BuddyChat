class PasswordValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty.";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters.";
    }
    if (value.length > 20) {
      return "Password cannot be more than 20 characters.";
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return "Password must contain at least one lowercase letter."; // Return error message
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return "Password must contain at least one uppercase letter."; // Return error message
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return "Password must contain at least one number."; // Return error message
    }

    if (RegExp(r"(1234568|password|qwerty|welcome|admin)")
        .hasMatch(value.toLowerCase())) {
      return "Password cannot contain common patterns like '12345678' or 'password et'."; // Return error message
    }

    return null; // Return null if all validations pass
  }
}
