import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/repoIm/repo_im.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/login_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/logout_usecase.dart';
import 'package:TaklyAPP/features/auth/domain/usecases/register_usercase.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthDatasource>(AuthDatasource.getInstance());
    Get.put(AuthRepoIm(dataSource: Get.find<AuthDatasource>()));
    Get.put<LoginUsecase>(LoginUsecase(authRepoIm: Get.find<AuthRepoIm>()));
    Get.put<RegisterUsecase>(
        RegisterUsecase(authRepoIm: Get.find<AuthRepoIm>()));
    Get.put(LogoutUsecase(authRepoIm: Get.find<AuthRepoIm>()));
    Get.put(ForgetPasswordUsecase(authRepoIm: Get.find<AuthRepoIm>()));
    Get.lazyPut<AuthCubit>(() => AuthCubit(
        authRepoIm: Get.find<AuthRepoIm>(),
        loginUsecase: Get.find<LoginUsecase>(),
        registerUsecase: Get.find<RegisterUsecase>(),
        logoutUsecase: Get.find<LogoutUsecase>(),
        forgetPasswordUsecase: Get.find<ForgetPasswordUsecase>()));
  }
}
