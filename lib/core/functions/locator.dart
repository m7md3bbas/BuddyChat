import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/logout_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/register_usercase.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupServiceLocator() {
  locator.registerFactory<AuthDatasource>(AuthDatasource.getInstance);
  locator
      .registerFactory<AuthRepoIm>(() => AuthRepoIm(locator<AuthDatasource>()));
  locator.registerFactory<LoginUsecase>(
      () => LoginUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory<LogoutUsecase>(
      () => LogoutUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory(
      () => ForgetPasswordUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory(
      () => RegisterUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerLazySingleton(() => AuthCubit(
        authRepoIm: locator<AuthRepoIm>(),
        forgetPasswordUsecase: locator<ForgetPasswordUsecase>(),
        loginUsecase: locator<LoginUsecase>(),
        logoutUsecase: locator<LogoutUsecase>(),
        registerUsecase: locator<RegisterUsecase>(),
      ));
}
