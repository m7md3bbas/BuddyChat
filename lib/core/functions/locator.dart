import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
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
import 'package:TaklyAPP/features/home/domain/usecases/add_new_contact_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/delete_contact_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_image_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_name_uasecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/get_users_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/pick_image_usecase.dart';
import 'package:TaklyAPP/features/home/domain/usecases/save_image_usecase.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
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
  locator.registerFactory<HomeRepoImpl>(
      () => HomeRepoImpl(dataSource: locator<HomeDataSource>()));
  locator.registerFactory<AddNewContactUsecase>(
      () => AddNewContactUsecase(locator<HomeRepoImpl>()));
  locator.registerFactory<DeleteContactUsecase>(
      () => DeleteContactUsecase(locator<HomeRepoImpl>()));
  locator.registerFactory<GetUsersUsecase>(
      () => GetUsersUsecase(locator<HomeRepoImpl>()));
  locator.registerFactory<GetNameUasecase>(
      () => GetNameUasecase(locator<HomeRepoImpl>()));
  locator.registerFactory<SaveImageUsecase>(
      () => SaveImageUsecase(locator<HomeRepoImpl>()));
  locator.registerFactory<GetImageUsecase>(
      () => GetImageUsecase(locator<HomeRepoImpl>()));
  locator.registerFactory<PickImageUseCase>(
      () => PickImageUseCase(locator<HomeRepoImpl>()));
  locator.registerLazySingleton(() => HomeCubit(
        locator<AddNewContactUsecase>(),
        locator<DeleteContactUsecase>(),
        locator<GetUsersUsecase>(),
        locator<GetNameUasecase>(),
        locator<SaveImageUsecase>(),
        locator<GetImageUsecase>(),
        locator<PickImageUseCase>(),
      ));
}
