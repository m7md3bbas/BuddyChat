part of 'auth_cubit.dart';

// @immutable
// sealed class AuthState {}

// final class AuthInitial extends AuthState {}

// final class Authloading extends AuthState {}

// final class AuthSuccess extends AuthState {
//   final UserEntity? userEntity;

//   AuthSuccess({this.userEntity});
// }

// final class AuthFailure extends AuthState {
//   final Failure failure;

//   AuthFailure({required this.failure});
// }

// final class Authenticated extends AuthState {
//   final UserEntity? userEntity;

//   Authenticated({required this.userEntity});
// // }

// final class UnAuthenticated extends AuthState {}

enum AuthStatus { authenticated, unauthenticated, loading, error }

extension AuthStatusX on AuthState {
  bool get loadind => status == AuthStatus.loading;
  bool get unauthenticated => status == AuthStatus.unauthenticated;
  bool get authenticated => status == AuthStatus.authenticated;
  bool get error => status == AuthStatus.error;
}

class AuthState {
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final AuthStatus status;
  final UserEntity? userEntity;
  final AuthExecption? failure;

  AuthState(
      {this.nameError,
      this.emailError,
      this.passwordError,
      this.confirmPasswordError,
      required this.status,
      this.userEntity,
      this.failure});

  AuthState copyWith({
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    AuthStatus? status,
    UserEntity? userEntity,
    AuthExecption? failure,
  }) =>
      AuthState(
          nameError: nameError ?? this.nameError,
          emailError: emailError ?? this.emailError,
          passwordError: passwordError ?? this.passwordError,
          confirmPasswordError:
              confirmPasswordError ?? this.confirmPasswordError,
          status: status ?? this.status,
          userEntity: userEntity ?? this.userEntity,
          failure: failure ?? this.failure);

  @override
  String toString() =>
      'AuthState(status: $status, userEntity: $userEntity, failure: $failure, nameError: $nameError, emailError: $emailError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.status == status &&
        other.userEntity == userEntity &&
        other.failure == failure &&
        other.nameError == nameError &&
        other.emailError == emailError &&
        other.passwordError == passwordError &&
        other.confirmPasswordError == confirmPasswordError;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      userEntity.hashCode ^
      failure.hashCode ^
      nameError.hashCode ^
      emailError.hashCode ^
      passwordError.hashCode ^
      confirmPasswordError.hashCode;
}
