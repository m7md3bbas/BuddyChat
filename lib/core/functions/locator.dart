import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/datasource/firebase_firestore_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/logout_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/register_usercase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/home/data/datasource/home_datasource.dart';
import 'package:TaklyAPP/features/home/domain/repoIm/home_repoim.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_current_user.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupServiceLocator() {
  locator.registerFactory<AuthDatasource>(AuthDatasource.getInstance);
  locator.registerFactory<FirebaseFirestoreAuthDatasource>(
      FirebaseFirestoreAuthDatasource.getInstance);
  locator.registerFactory<AuthRepoIm>(() => AuthRepoIm(
      locator<AuthDatasource>(), locator<FirebaseFirestoreAuthDatasource>()));
  locator.registerFactory<LoginUsecase>(
      () => LoginUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory<LogoutUsecase>(
      () => LogoutUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory(
      () => ForgetPasswordUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory(
      () => RegisterUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerFactory(
      () => GoogleLoginUsecase(authRepoIm: locator<AuthRepoIm>()));
  locator.registerLazySingleton(() => AuthCubit(
        googleLoginUsecase: locator<GoogleLoginUsecase>(),
        resetPasswordUsecase: locator<ResetPasswordUsecase>(),
        authRepoIm: locator<AuthRepoIm>(),
        forgetPasswordUsecase: locator<ForgetPasswordUsecase>(),
        loginUsecase: locator<LoginUsecase>(),
        logoutUsecase: locator<LogoutUsecase>(),
        registerUsecase: locator<RegisterUsecase>(),
      ));
  locator.registerFactory<HomeDataSource>(HomeDataSource.getInstance);
  locator.registerFactory<HomeRepoImpl>(() => HomeRepoImpl(
      dataSource: locator<HomeDataSource>(),
      firebaseFirestoreDataSource: locator<FirebaseFirestoreAuthDatasource>()));
  locator.registerFactory<GetCurrentUser>(
      () => GetCurrentUser(homeRepoImpl: locator<HomeRepoImpl>()));
  locator.registerLazySingleton(() => HomeCubit(
        getCurrentUser: locator<GetCurrentUser>(),
      ));
}
