class ConfirmPasswords {
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password cannot be empty."; // Return error message
    }
    if (value != password) {
      return "Password and Confirm Password does not match."; // Return error message
    }
  
    return null;
  }
}
