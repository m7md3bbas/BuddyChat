class ErrorHandler{

  ErrorHandler._();
  static ErrorHandler? _instance ;
  static ErrorHandler  getErrorHandler(){
    _instance??=ErrorHandler._();
    return _instance!;
  }

  String handleRegisterError(String error){
    switch (error) {
      case "error_invalid_email":
        error = "Invalid Email Address";
        break;
      case "error_too_many_requests":
        error = "To Many Requests";
        break;
      case "error_operation_not_allowed":
        error = "Cannot Create Account Now Try Again Later";
        break;
      case "email-already-in-use":
        error = "Email Already In Use";
        break;
      default:
        error = error.toString();
    }
    return error;
  }

  String handleLoginError(String error){
    switch (error) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        error = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        error = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        error = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        error = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        error = "Email address is invalid.";
        break;
      default:
        error = "Login failed. Please try again.";
        break;
    }
    return error;
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