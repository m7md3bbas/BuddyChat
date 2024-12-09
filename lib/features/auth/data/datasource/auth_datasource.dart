
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthDatasource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

  Future<UserEntity?> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
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
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firebasefirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        'email': email,
        'password': password,
        'uid': firebaseAuth.currentUser!.uid,
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
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred during logout");
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Error", e.message ?? "An error occurred during password reset");
    }
  }
}
