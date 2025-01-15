import 'dart:async';
import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/logout_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/register_usercase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final AuthRepoIm authRepoIm;
  late StreamSubscription<UserEntity?> _authStateSubscription;
  final ResetPasswordUsecase resetPasswordUsecase;
  final GoogleLoginUsecase googleLoginUsecase;
  AuthCubit({
    required this.googleLoginUsecase,
    required this.resetPasswordUsecase,
    required this.authRepoIm,
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.forgetPasswordUsecase,
  }) : super(AuthState(status: AuthStatus.unauthenticated));

  void checkAuth() {
    _authStateSubscription = authRepoIm.authStateChange.listen((user) {
      emit(state.copyWith(
        status: user != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
        userEntity: user,
      ));
    });
  }

  Future<void> googleLogin() async {
    emit(state.copyWith(status: AuthStatus.loading));
    var user = await googleLoginUsecase.call();
    user.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        userEntity: user,
      )),
    );
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        failure: AuthExecption("Email and password are required."),
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await loginUsecase(email: email, password: password);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        userEntity: user,
      )),
    );
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        failure: AuthExecption("ALL Fields are required."),
      ));

      return;
    }

    emit(AuthState(status: AuthStatus.loading));
    final result =
        await registerUsecase(email: email, password: password, name: name);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        failure: failure,
      )),
      (user) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        userEntity: user,
      )),
    );
  }

  Future<void> logoutUser() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await logoutUsecase.call();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        failure: AuthExecption(e.toString()),
      ));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    if (email.isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        failure: AuthExecption("Email is required."),
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await forgetPasswordUsecase.call(email: email);
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        failure: AuthExecption(e.toString()),
      ));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
