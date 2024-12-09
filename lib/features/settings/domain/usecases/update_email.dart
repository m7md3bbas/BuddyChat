import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:dartz/dartz.dart';

class UpdateEmailUsecase {
  final SettingRepoim settingRepoim;

  UpdateEmailUsecase(this.settingRepoim);

  Future<Either<Failure, void>> call({required String email,required String password}) async =>
      await settingRepoim.updateEmail(email: email,password: password);
}
