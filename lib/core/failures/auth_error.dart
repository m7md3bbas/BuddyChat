// auth_error.dart
class AuthError {
  /// Returns a user-friendly error message based on the FirebaseAuthException code.
 static String getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password provided.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
