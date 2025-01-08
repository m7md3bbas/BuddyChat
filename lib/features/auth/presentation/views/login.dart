import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final ValueNotifier<bool> isObscuredNotifier = ValueNotifier<bool>(true);
  final passwordController = TextEditingController();
  bool isobscure = true;
  var cubit = Get.find<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: cubit,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
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
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscuredNotifier,
                          builder: (context, isObscured, child) {
                            return MyTextField(
                              type: 'Password',
                              controller: passwordController,
                              obscure: isObscured,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: isObscuredNotifier,
                              builder: (context, isObscured, child) {
                                return Checkbox(
                                  value: !isObscured,
                                  onChanged: (value) {
                                    isObscuredNotifier.value = !isObscured;
                                  },
                                );
                              },
                            ),
                            const Text('Show Password'),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/forgetPassword');
                              },
                              child: GestureDetector(
                                onTap: () => Get.toNamed('/forgetPassword'),
                                child: Obx(() {
                                  return Text(
                                    'forgetPassword'.tr,
                                    style: TextStyle(
                                      fontSize: Get.find<FontSizeController>()
                                          .fontSize
                                          .value,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                              onTap: () {
                                Get.toNamed('/register');
                              },
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

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      cubit.loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar("Error", "Please enter all the fields");
    }
  }
}
