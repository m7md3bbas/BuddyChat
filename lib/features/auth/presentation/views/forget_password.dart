import 'package:TaklyAPP/core/validtors/email_validator.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  
  TextEditingController emailController = TextEditingController();
  var cubit = Get.find<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "forgetPassword".tr,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Get.snackbar(
              "Success",
              "Password reset email sent successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            emailController.clear();
          } else if (state is AuthFailure) {
            Get.snackbar(
              "Error",
              state.failure.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "enterYourEmailAddressToResetYourPassword".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      type: "email".tr,
                      obscure: false,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    state is Authloading
                        ? const CircularProgressIndicator.adaptive()
                        : MyButton(
                            name: "send".tr,
                            onPressed: forgetPassword,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void forgetPassword() {
    final email = emailController.text.trim();
    if (email.isNotEmpty && EmailValidators.validateEmail(email) != null) {
      cubit.forgetPassword(email: email);
    } else {
      Get.snackbar(
        "Error",
        "Please enter a valid email address",
      );
    }
  }
}
