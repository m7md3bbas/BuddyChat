import 'dart:async';

import 'package:TaklyAPP/core/failures/auth_error.dart';
import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  static AuthDatasource? _instance;
  AuthDatasource._({required this.errorHandler});

  static AuthDatasource getInstance() {
    _instance ??=
        AuthDatasource._(errorHandler: ErrorHandler.getErrorHandler());
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ErrorHandler errorHandler;
  Stream<UserEntity?> get authStateChange {
    return _firebaseAuth.authStateChanges().map((user) {
      return user != null ? Users.fromFirebase(user) : null;
    });
  }

  Future<UserEntity?> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      return UserEntity(id: user!.uid, email: user.email ?? "No Email Found");
    } on FirebaseAuthException catch (e) {
      var error = errorHandler.getAuthErrorMessage(e);
      throw AuthExecption(error);
    } on TimeoutException catch (e) {
      throw AuthExecption(e.message!);
    }
  }

  Future<UserEntity?> register({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      return UserEntity(id: user!.uid, email: user.email ?? "No Email Found");
    } on FirebaseAuthException catch (e) {
      var error = errorHandler.getAuthErrorMessage(e);
      throw AuthExecption(error);
    } on TimeoutException catch (e) {
      throw AuthExecption(e.message!);
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      var error = errorHandler.getAuthErrorMessage(e);
      throw AuthExecption(error);
    } on TimeoutException catch (e) {
      throw AuthExecption(e.message!);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      var error = errorHandler.getAuthErrorMessage(e);
      throw AuthExecption(error);
    } on TimeoutException catch (e) {
      throw AuthExecption(e.message!);
    }
  }
}

class AuthExecption {
  final String message;
  AuthExecption(this.message);
}
