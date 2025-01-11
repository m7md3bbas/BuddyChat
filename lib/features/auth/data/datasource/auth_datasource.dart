import 'dart:async';

import 'package:TaklyAPP/core/failures/auth_error.dart';
import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDatasource {
  static AuthDatasource? _instance;
  AuthDatasource._({required this.errorHandler});

  static AuthDatasource getInstance() {
    _instance ??= AuthDatasource._(
      errorHandler: ErrorHandler.getErrorHandler(),
    );
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ErrorHandler errorHandler;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<UserEntity?> googleLogin() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user != null
        ? Users.fromFirebase(userCredential.user!)
        : null;
  }

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

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      var error = errorHandler.getAuthErrorMessage(e);
      throw AuthExecption(error);
    } on TimeoutException catch (e) {
      throw AuthExecption(e.message!);
    }
  }

  Future<void> resetPassword(
      {required String code, required String newPassword}) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
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
