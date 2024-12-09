import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/settings/data/datasource/setting_datasource.dart';
import 'package:TaklyAPP/features/settings/data/repo/setting_repo.dart';
import 'package:dartz/dartz.dart';

class SettingRepoim implements SettingRepo {
  SettingDatasource datasource;
  SettingRepoim(this.datasource);

  @override
  Future<Either<Failure, void>> changeName({required String name}) async {
    try {
      return Right(await datasource.updateName(name: name));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String newPassword}) async {
    try {
      return Right(await datasource.updatePassword(newPassword: newPassword));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmail({required String email, required String password}) async {
    try {
      return Right(await datasource.updateEmail(email: email, password: password));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(
      { required String password}) async {
    try {
      return Right(await datasource.deleteAccount( password));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPassword() async {
    try {
      final password = await datasource.getPassword();
      return Right(password);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
