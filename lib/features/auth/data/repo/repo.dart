import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class Repo {
  Future<Either<AuthExecption, UserEntity?>> login(
      {required String email, required String password});
  Future<Either<AuthExecption, UserEntity?>> register(
      {required String email, required String password});
  Future<Either<AuthExecption, void>> logout();
  Future<Either<AuthExecption, void>> sendPasswordResetEmail(
      {required String email});
  Future<Either<AuthExecption, void>> resetPassword(
      {required String code, required String newPassword});
  Future<Either<AuthExecption, UserEntity?>> googleSignIn();

  Stream<UserEntity?> get authStateChange;
}
