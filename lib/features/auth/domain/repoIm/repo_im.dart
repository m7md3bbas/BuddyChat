import 'dart:developer';

import 'package:TaklyAPP/features/auth/data/datasource/auth_datasource.dart';
import 'package:TaklyAPP/features/auth/data/datasource/firebase_firestore_datasource.dart';
import 'package:TaklyAPP/features/auth/data/repo/repo.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class AuthRepoIm implements Repo {
  final AuthDatasource _dataSource;
  final FirebaseFirestoreDatasource _firebaseFirestoreDatasource;
  AuthRepoIm(
    this._dataSource,
    this._firebaseFirestoreDatasource,
  );

  @override
  Future<Either<AuthExecption, UserEntity?>> login(
      {required String email, required String password}) async {
    try {
      final user = await _dataSource.login(email: email, password: password);
      UserEntity verifyUser =
          await _firebaseFirestoreDatasource.getUser(userEntity: user!);
      if (verifyUser.id != user.id) {
        log(verifyUser.email);
        return Left(AuthExecption("User not found"));
      }

      return Right(user);
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
      final user = await _dataSource.register(email: email, password: password);
      if (user != null) {
        _firebaseFirestoreDatasource.createUser(userEntity: user);
      }
      return Right(user);
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
  Future<Either<AuthExecption, void>> sendPasswordResetEmail(
      {required String email}) async {
    try {
      return Right(await _dataSource.sendPasswordResetEmail(email: email));
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Stream<UserEntity?> get authStateChange => _dataSource.authStateChange;

  @override
  Future<Either<AuthExecption, void>> resetPassword(
      {required String code, required String newPassword}) async {
    try {
      return Right(await _dataSource.resetPassword(
          code: code, newPassword: newPassword));
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }

  @override
  Future<Either<AuthExecption, UserEntity?>> googleSignIn() async {
    try {
      return Right(await _dataSource.googleLogin());
    } on AuthExecption catch (e) {
      return Left(AuthExecption(e.message));
    }
  }
}
