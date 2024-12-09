import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:dartz/dartz.dart';

class DeleteAccountUsecase {
  final SettingRepoim settingRepoim;

  DeleteAccountUsecase(this.settingRepoim);

  Future<Either<Failure, void>> call(
          { required String password}) async =>
      await settingRepoim.deleteAccount( password: password);
}
