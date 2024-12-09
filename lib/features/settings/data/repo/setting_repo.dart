import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRepo {
  Future<Either<Failure, void>> changePassword({required String newPassword});
  Future<Either<Failure, void>> changeName({required String name});
  Future<Either<Failure, void>> updateEmail({required String email,required String password});
  Future<Either<Failure, void>> deleteAccount({required String password });
  Future<Either<Failure, String>> getPassword();
}
