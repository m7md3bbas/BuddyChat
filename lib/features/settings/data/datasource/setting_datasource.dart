import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingDatasource {
  final firebaseAuth = FirebaseAuth.instance;
  final firebasefirestore = FirebaseFirestore.instance;
  Future<void> updatePassword({required String newPassword}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        user.reauthenticateWithCredential;
        await firebasefirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update({'password': newPassword});
        Get.snackbar("Success", "Password updated successfully");
      } else {
        throw Exception("No authenticated user found");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateEmail({required String email , required String password}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        // Check if the new email already exists in the Firestore collection
        QuerySnapshot querySnapshot = await firebasefirestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          throw Exception("Email already exists");
        }

        // Reauthenticate the user before updating email (if required)
        // If the user hasn't been recently authenticated, you may need to reauthenticate
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password:password, // Add the user's password here
        );
        await user.reauthenticateWithCredential(credential);

        // Update the email address
        await user.verifyBeforeUpdateEmail(email);

        // Send verification email
        await user.sendEmailVerification();

        // Wait for the user to verify the new email address
        Get.snackbar("Notification",
            "Verification email sent to your new email address.");

        // Update the email in Firestore
        await firebasefirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update({
          'email': email,
        });

        // Optionally, check if the email is verified (to ensure the user can continue)
        if (user.emailVerified) {
          Get.snackbar("Success", "Email updated and verified!");
        } else {
          // If email is not verified, notify the user
          Get.snackbar("Reminder", "Please verify your new email address.");
        }
      } else {
        throw Exception("No authenticated user found");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Error", e.message ?? "An error occurred during email change");
    }
  }

  Future<void> updateName({required String name}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await firebasefirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .update({
          'name': name,
        });
      } else {
        throw Exception("No authenticated user found");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Error", e.message ?? "An error occurred during name change");
    }
  }

  Future<void> deleteAccount(String password) async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw Exception("No authenticated user found");
      }

      // Reauthenticate the user
      final credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);

      // Delete the user's data from Firestore
      final userId = user.uid;
      await firebasefirestore.collection('users').doc(userId).delete();

      // Delete the user's account
      await user.delete();
      Get.snackbar("Success", "Account deleted successfully");
      FirebaseAuth.instance.signOut(); // Log out user
      Get.offAllNamed('/login');
      // Notify the user
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth-specific errors
      String errorMessage;
      switch (e.code) {
        case 'requires-recent-login':
          errorMessage = "Please log in again to delete your account.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'user-not-found':
          errorMessage = "No user found with these credentials.";
          break;
        default:
          errorMessage = e.message ?? "An unexpected error occurred.";
      }
      Get.snackbar("Error", errorMessage);
      throw Exception(errorMessage);
    } catch (e) {
      // Handle generic exceptions
      Get.snackbar("Error", e.toString());
      throw Exception("Account deletion failed: ${e.toString()}");
    }
  }

  Future<String> getPassword() async {
    final user = firebaseAuth.currentUser;
    try {
      QuerySnapshot querySnapshot = await firebasefirestore
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String password = querySnapshot.docs.first['password'];
        return password;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return '';
  }
}
