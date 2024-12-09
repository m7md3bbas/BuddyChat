import 'package:get/get.dart';

class EmailValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      Get.snackbar("Error", "Email cannot be empty.");
      return "Email cannot be empty."; // Return error message
    }

    // Basic email pattern to check if the email is in the correct format
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      Get.snackbar("Error", "Please enter a valid email address.");
      return "Please enter a valid email address."; // Return error message
    }

    return null; // Return null if the email is valid
  }
}
