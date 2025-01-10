

class NameValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty."; // Return error message
    }

    // Check if name length is within reasonable limits
    if (value.length < 2) {
      return "Name must be at least 2 characters."; // Return error message
    }
    if (value.length > 50) {
      return "Name cannot be more than 50 characters."; // Return error message
    }

    // Check if name contains only alphabetic characters, spaces, hyphens, and apostrophes
    if (!RegExp(r"^[ا-يa-zA-Z\s\-\'\.]+$").hasMatch(value)) {
      return "Name can only contain letters, spaces, hyphens, and apostrophes."; // Return error message
    }

    // Return null if all validations pass
    return null; // Return null if name is valid
  }
}
