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
import 'package:TaklyAPP/features/settings/data/datasource/setting_datasource.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/delete_account_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/get_password.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_email.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_name_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_password_usecase.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';

class CubitConstractor {
  static HomeCubit homeConstractorMethod() {
    return HomeCubit(
      AddNewContactUsecase(HomeRepoImpl(HomeDataSource())),
      DeleteContactUsecase(HomeRepoImpl(HomeDataSource())),
      GetUsersUsecase(HomeRepoImpl(HomeDataSource())),
      GetNameUasecase(HomeRepoImpl(HomeDataSource())),
      SaveImageUsecase(HomeRepoImpl(HomeDataSource())),
      GetImageUsecase(HomeRepoImpl(HomeDataSource())),
      PickImageUseCase(HomeRepoImpl(HomeDataSource())),
    );
  }

  static SettingsCubit settingContractorCubit() {
    return SettingsCubit(
      DeleteAccountUsecase(SettingRepoim(SettingDatasource())),
      UpdatePasswordUsecase(SettingRepoim(SettingDatasource())),
      UpdateEmailUsecase(SettingRepoim(SettingDatasource())),
      UpdateNameUsecase(SettingRepoim(SettingDatasource())),
      GetPasswordUsecase(SettingRepoim(SettingDatasource())),
    );
  }
}
