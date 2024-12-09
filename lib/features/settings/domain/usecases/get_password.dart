import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:dartz/dartz.dart';

class GetPasswordUsecase {
  final SettingRepoim settingRepoim;
  GetPasswordUsecase(this.settingRepoim);

  Future<Either<Failure, String>> call() async =>
      await settingRepoim.getPassword();
}
