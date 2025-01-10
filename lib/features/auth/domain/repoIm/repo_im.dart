import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/repo/repo.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class AuthRepoIm implements Repo {
  final AuthDatasource _dataSource;
  AuthRepoIm(
    this._dataSource,
  );

  @override
  Future<Either<AuthExecption, UserEntity?>> login(
      {required String email, required String password}) async {
    try {
      return Right(await _dataSource.login(email: email, password: password));
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Future<Either<AuthExecption, UserEntity?>> register({
    required String email,
    required String password,
  }) async {
    try {
      return Right(
          await _dataSource.register(email: email, password: password));
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Future<Either<AuthExecption, void>> logout() async {
    try {
      return Right(await _dataSource.logout());
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Future<Either<AuthExecption, void>> forgetPassword(
      {required String email}) async {
    try {
      return Right(await _dataSource.resetPassword(email: email));
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Stream<UserEntity?> get authStateChange => _dataSource.authStateChange;
}
