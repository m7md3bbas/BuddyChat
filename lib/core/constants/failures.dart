
abstract class Failure {
  final String message;

  Failure(this.message);

}

class AuthFailure extends Failure {
  AuthFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class GeneralFailure extends Failure {
  GeneralFailure(super.message);
}
