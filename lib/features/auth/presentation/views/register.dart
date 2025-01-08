import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/widgets/show_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isObscuredNotifier = ValueNotifier<bool>(true);
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
          bloc: cubit,
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.height * 0.0045,
                        ),
                        Icon(
                          Icons.chat,
                          size:
                              Get.find<FontSizeController>().fontSize.value * 5,
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
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isObscuredNotifier,
                                builder: (context, isObscured, child) {
                                  return MyTextField(
                                    type: 'Password',
                                    controller: passwordController,
                                    obscure: isObscured,
                                  );
                                },
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 5,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isObscuredNotifier,
                                builder: (context, isObscured, child) {
                                  return MyTextField(
                                    type: 'confirm Password',
                                    controller: confirmPasswordController,
                                    obscure: isObscured,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ShowPassword(
                            isLogin: false,
                            isObscuredNotifier: isObscuredNotifier),
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
                              onTap: () {
                                Get.back();
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
    final String fullName =
        "${fnameController.text.trim()} ${lnameController.text.trim()}";

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
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          fnameController.clear();
          lnameController.clear();
        } catch (e) {
          Get.snackbar("Error", "An error occurred during registration.");
        }
      } else {
        passwordController.clear();
        confirmPasswordController.clear();
        Get.snackbar("Error", "Passwords do not match");
      }
    } else {
      Get.snackbar("Error", "Please fill in all fields");
    }
  }
}
