part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authloading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity? userEntity;

  AuthSuccess({ this.userEntity});
}

final class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure({required this.failure});
}

final class Authenticated extends AuthState {
  final UserEntity userEntity;

  Authenticated({required this.userEntity});
}
final class UnAuthenticated extends AuthState {}
