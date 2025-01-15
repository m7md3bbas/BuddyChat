import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetSnacbars {
  static void errorSnackbar(String message) {
    Get.snackbar(
      icon: const Icon(Icons.error),
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color.fromARGB(255, 152, 34, 26),
      colorText: Colors.white,
      dismissDirection: DismissDirection.vertical,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(vertical: 20),
    );
  }

  static void successSnackbar(String message) {
    Get.snackbar(
      icon: const Icon(Icons.check),
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      dismissDirection: DismissDirection.vertical,
      animationDuration: const Duration(milliseconds: 300),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}
