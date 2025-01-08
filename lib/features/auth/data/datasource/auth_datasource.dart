import 'package:TaklyAPP/features/auth/data/model/user.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthDatasource {
  static AuthDatasource? _instance;
  AuthDatasource._();

  static AuthDatasource getInstance() {
    _instance ??= AuthDatasource._();
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      if (user != null) {
        return UserEntity(id: user.uid, email: user.email ?? "No Email Found");
      } else {
        Get.snackbar("Error", "Login failed");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred during login");
    }
    return null;
  }

  Future<UserEntity?> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'email': email,
        'password': password,
        'uid': _firebaseAuth.currentUser!.uid,
        'name': name
      });
      final user = userCredential.user;
      if (user != null) {
        return UserEntity(id: user.uid, email: user.email ?? "No Email Found");
      } else {
        Get.snackbar("Error", "Registration failed");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Error", e.message ?? "An error occurred during registration");
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred during logout");
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Error", e.message ?? "An error occurred during password reset");
    }
  }
}
