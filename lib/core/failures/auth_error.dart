import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler{

  ErrorHandler._();
  static ErrorHandler? _instance ;
  static ErrorHandler  getErrorHandler(){
    _instance??=ErrorHandler._();
    return _instance!;
  }

  String getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'user-token-expired':
        return 'Your session has expired. Please log in again.';
      case 'invalid-credential':
        return 'The provided credentials are incorrect or have expired.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email but using a different sign-in provider.';
      case 'requires-recent-login':
        return 'Please reauthenticate to perform this operation.';
      case 'app-deleted':
        return 'The app has been deleted.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }


  String handleFirebaseFireStoreError(String error){
    switch (error) {
      case "ABORTED":
        error = "The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.";
        break;
      case "ALREADY_EXISTS":
        error = "Some document that we attempted to create already exists.";
        break;
      case "CANCELLED":
        error = "The operation was cancelled (typically by the caller).";
        break;
      case "DATA_LOSS":
        error = 'Unrecoverable data loss or corruption.';
        break;
      case "DEADLINE_EXCEEDED":
        error = "Deadline expired before operation could complete.";
        break;
      case "FAILED_PRECONDITION":
        error = "Operation was rejected because the system is not in a state required for the operation's execution.";
        break;
      case "INTERNAL":
        error = "Internal errors.";
        break;
      case "INVALID_ARGUMENT":
        error = "Client specified an invalid argument.";
        break;
      case "NOT_FOUND":
        error = "Some requested document was not found.";
        break;
      case "OK":
        error = "The operation completed successfully.";
        break;
      case "OUT_OF_RANGE":
        error = "Operation was attempted past the valid range.";
        break;
      case "PERMISSION_DENIED":
        error = "The caller does not have permission to execute the specified operation.";
        break;
      case "RESOURCE_EXHAUSTED":
        error = "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";
        break;
      case "UNAUTHENTICATED":
        error = "The request does not have valid authentication credentials for the operation.";
        break;
      case "UNAVAILABLE":
        error = "The service is currently unavailable.";
        break;
      case "UNIMPLEMENTED":
        error = "Operation is not implemented or not supported/enabled.";
        break;
      case "UNKNOWN":
        error = "Unknown error or an error from a different error domain.";
        break;
      default:
        error = "Some Thing Went Wrong";
        break;
    }
    return error;
  }

}