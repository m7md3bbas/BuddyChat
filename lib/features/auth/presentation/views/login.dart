import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/forget_password.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.toogleAuthGate, this.toForgetPassword});

  final void Function()? toogleAuthGate;

  final void Function()? toForgetPassword;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isloading = false;
  bool isobscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure) {
            return Center(
              child: Obx(() {
                return Text(
                  state.failure.message,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }),
            );
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
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
                          'signIn'.tr,
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
                      MyTextField(
                          controller: emailController,
                          obscure: false,
                          type: "email".tr),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isobscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isobscure = !isobscure;
                              });
                            },
                          ),
                          controller: passwordController,
                          obscure: isobscure,
                          type: "password".tr),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => BlocProvider(
                                  create: (context) =>
                                      CubitConstractor.authConstractorMethod(),
                                  child: ForgetPasswordPage(),
                                )),
                            child: Obx(() {
                              return Text(
                                'forgetPassword'.tr,
                                style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state is Authloading
                          ? const CircularProgressIndicator()
                          : MyButton(
                              name: "signIn".tr,
                              onPressed: login,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(
                              'dontHaveAnAccount'.tr,
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
                            onTap: widget.toogleAuthGate,
                            child: Obx(() {
                              return Text(
                                'signUp'.tr,
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void login() {
    unfocusKeyboard();
    setState(() {
      isloading = true;
    });
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      BlocProvider.of<AuthCubit>(context).loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar("Error", "Please enter all the fields");
    }

    setState(() {
      isloading = false;
    });
  }
}
