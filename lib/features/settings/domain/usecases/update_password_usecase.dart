import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUsecase {
  final SettingRepoim settingRepoim;

  UpdatePasswordUsecase(this.settingRepoim);
  Future<Either<Failure, void>> call({required String newPassword}) async =>
      await settingRepoim.changePassword(newPassword: newPassword);
}
