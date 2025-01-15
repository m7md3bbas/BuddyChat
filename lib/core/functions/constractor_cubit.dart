import 'package:TaklyAPP/features/settings/data/datasource/setting_datasource.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/delete_account_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/get_password.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_email.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_name_usecase.dart';
import 'package:TaklyAPP/features/settings/domain/usecases/update_password_usecase.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';

class CubitConstractor {
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
