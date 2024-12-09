import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/domain/repoIm/settings_repoim.dart';
import 'package:dartz/dartz.dart';

class UpdateNameUsecase {
  final SettingRepoim settingRepoim;

  UpdateNameUsecase(this.settingRepoim);

  Future<Either<Failure, void>> call({required String name}) async =>
      await settingRepoim.changeName(name: name);
}
