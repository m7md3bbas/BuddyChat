import 'package:get/get.dart';

class NameValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty.");
      return "Name cannot be empty."; // Return error message
    }

    // Check if name length is within reasonable limits
    if (value.length < 2) {
      Get.snackbar("Error", "Name must be at least 2 characters.");
      return "Name must be at least 2 characters."; // Return error message
    }
    if (value.length > 50) {
      Get.snackbar("Error", "Name cannot be more than 50 characters.");
      return "Name cannot be more than 50 characters."; // Return error message
    }

    // Check if name contains only alphabetic characters, spaces, hyphens, and apostrophes
    if (!RegExp(r"^[ا-يa-zA-Z\s\-\'\.]+$").hasMatch(value)) {
      Get.snackbar("Error",
          "Name can only contain letters, spaces, hyphens, and apostrophes.");
      return "Name can only contain letters, spaces, hyphens, and apostrophes."; // Return error message
    }

    // Return null if all validations pass
    return null; // Return null if name is valid
  }
}
