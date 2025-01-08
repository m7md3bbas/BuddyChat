import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/repo/repo.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoIm implements Repo {
  final AuthDatasource dataSource;
  AuthRepoIm({required this.dataSource});

  @override
  Future<Either<Failure, UserEntity?>> login(
      {required String email, required String password}) async {
    try {
      return Right(await dataSource.login(email: email, password: password));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      return Right(await dataSource.register(
          email: email, password: password, name: name));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.code));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await dataSource.logout());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      return Right(await dataSource.resetPassword(email: email));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.code));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChange => dataSource.authStateChange;
}
