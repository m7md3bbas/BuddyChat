
import 'package:get/get.dart';

class PasswordValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      throw Exception("Password cannot be empty.");
    }
    if (value.length < 8) {
      throw Exception("Password must be at least 8 characters.");
    }
    if (value.length > 20) {
      throw Exception("Password cannot be more than 20 characters.");
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      Get.snackbar(
          "Error", "Password must contain at least one lowercase letter.");
      return "Password must contain at least one lowercase letter."; // Return error message
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      Get.snackbar(
          "Error", "Password must contain at least one uppercase letter.");
      return "Password must contain at least one uppercase letter."; // Return error message
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      Get.snackbar("Error", "Password must contain at least one number.");
      return "Password must contain at least one number."; // Return error message
    }

    if (RegExp(r"(1234568|password|qwerty|welcome|admin)")
        .hasMatch(value.toLowerCase())) {
      Get.snackbar("Error",
          "Password cannot contain common patterns like '12345678' or 'password et'.");
      return "Password cannot contain common patterns like '12345678' or 'password et'."; // Return error message
    }

    return null; // Return null if all validations pass
  }
}
