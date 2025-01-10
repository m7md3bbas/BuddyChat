class EmailValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty."; // Return error message
    }

    // Basic email pattern to check if the email is in the correct format
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      return "Please enteds a valid email address."; // Return error message
    }

    return null; // Return null if the email is valid
  }
}
