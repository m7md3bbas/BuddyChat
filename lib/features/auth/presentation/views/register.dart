import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/validtors/email_validator.dart';
import 'package:TaklyAPP/core/validtors/name_validator.dart';
import 'package:TaklyAPP/core/validtors/password_validators.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key,});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final fnameController = TextEditingController();

  final lnameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  bool isloading = false;
  bool isobscure = true;
 var cubit = Get.find<AuthCubit>(); 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: BlocBuilder<AuthCubit, AuthState>(
          bloc:cubit,
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          size: 60,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Obx(() {
                          return Text(
                            'signUp'.tr,
                            style: TextStyle(
                              fontSize:
                                  Get.find<FontSizeController>().fontSize.value,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                  controller: fnameController,
                                  obscure: false,
                                  type: "firstName".tr),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                  controller: lnameController,
                                  obscure: false,
                                  type: "lastName".tr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MyTextField(
                            controller: emailController,
                            obscure: false,
                            type: "email".tr),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                  controller: passwordController,
                                  obscure: isobscure,
                                  type: "password".tr),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      !isobscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isobscure = !isobscure;
                                      });
                                    },
                                  ),
                                  controller: confirmPasswordController,
                                  obscure: isobscure,
                                  type: "confirmPassword".tr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is Authloading
                            ? const CircularProgressIndicator()
                            : MyButton(
                                name: "signUp".tr,
                                onPressed: register,
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Text(
                                "alreadyHaveAnaccount".tr,
                                style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            }),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap:(){
                                Get.toNamed("/");
                              },
                              child: Obx(() {
                                return Text(
                                  "signIn".tr,
                                  style: TextStyle(
                                      fontSize: Get.find<FontSizeController>()
                                          .fontSize
                                          .value,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void register() async {
    unfocusKeyboard();
    setState(() {
      isloading = true;
    });

    final String fullName =
        "${fnameController.text.trim()} ${lnameController.text.trim()}";

    // Step 1: Validate fields
    if (EmailValidators.validateEmail(emailController.text.trim()) != null ||
        PasswordValidators.validatePassword(passwordController.text.trim()) !=
            null ||
        NameValidators.validateName(fullName) != null) {
      setState(() {
        isloading = false;
      });
      return; // Stop execution if any validation fails
    }

    // Step 2: Check if all fields are filled
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      // Step 3: Check password match
      if (passwordController.text == confirmPasswordController.text) {
        try {
          // Register the user
          cubit.registerUser(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              name: fullName);
          // Optionally clear the controllers here after successful registration
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          fnameController.clear();
          lnameController.clear();
        } catch (e) {
          // Handle errors during registration
          Get.snackbar("Error", "An error occurred during registration.");
          // Log error for debugging
        }
      } else {
        // Passwords don't match
        passwordController.clear();
        confirmPasswordController.clear();
        Get.snackbar("Error", "Passwords do not match");
      }
    } else {
      // One or more fields are empty
      Get.snackbar("Error", "Please fill in all fields");
    }

    // Step 4: Reset loading state after registration attempt
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  void unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
