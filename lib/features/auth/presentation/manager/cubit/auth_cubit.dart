import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/logout_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/register_usercase.dart';
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  AuthCubit(this.loginUsecase, this.registerUsecase, this.logoutUsecase,
      this.forgetPasswordUsecase)
      : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(Authloading());
    final result = await loginUsecase(email: email, password: password);
    result.fold((l) => emit(AuthFailure(failure: l)),
        (r) => emit(AuthSuccess(userEntity: r)));
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String name}) async {
    emit(Authloading());
    final result =
        await registerUsecase(email: email, password: password, name: name);
    result.fold((l) => emit(AuthFailure(failure: l)),
        (r) => emit(AuthSuccess(userEntity: r)));
  }

  Future<void> logoutUser() async {
    emit(Authloading());
    try {
      await logoutUsecase.call();
      emit(AuthSuccess(userEntity: UserEntity(id: '', email: '')));
    } catch (e) {
      emit(AuthFailure(failure: GeneralFailure(e.toString())));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(Authloading());
    try {
      await forgetPasswordUsecase.call(email: email);
      await Future.delayed(const Duration(seconds: 2));
      // Example async call
      emit(AuthSuccess(userEntity: UserEntity(id: '', email: '')));
    } catch (e) {
      emit(AuthFailure(failure: GeneralFailure(e.toString())));
    }
  }

}
