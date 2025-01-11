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
  final AuthStatus status;
  final UserEntity? userEntity;
  final AuthExecption? failure;

  AuthState({required this.status, this.userEntity, this.failure});

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? userEntity,
    AuthExecption? failure,
  }) =>
      AuthState(
          status: status ?? this.status,
          userEntity: userEntity ?? this.userEntity,
          failure: failure ?? this.failure);

  @override
  String toString() =>
      'AuthState(status: $status, userEntity: $userEntity, failure: $failure, )';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.status == status &&
        other.userEntity == userEntity &&
        other.failure == failure;
  }

  @override
  int get hashCode => status.hashCode ^ userEntity.hashCode ^ failure.hashCode;
}
