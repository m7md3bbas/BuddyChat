import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/forget_password.dart';
import 'package:TaklyAPP/features/auth/presentation/views/register.dart';
import 'package:TaklyAPP/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _loginEmailController;
  late final TextEditingController _loginPasswordController;
  bool _isobscure = true;
  final _loginFormKey = GlobalKey<FormState>();
  @override
  initState() {
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeView()));
              }
              if (state.status == AuthStatus.error) {
                Get.snackbar('Error', state.failure!.message);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: context.height * 0.15),
                      Icon(
                        Icons.chat,
                        size: Get.find<FontSizeController>().fontSize.value * 5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 50),
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
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: _loginEmailController,
                        obscure: false,
                        type: "email".tr,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: _loginPasswordController,
                        type: 'Password',
                        obscure: _isobscure,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: !_isobscure,
                            onChanged: (value) {
                              setState(() {
                                _isobscure = !_isobscure;
                              });
                            },
                          ),
                          const Text('Show Password'),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordPage()),
                            ),
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
                      const SizedBox(height: 20),
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          return state.status == AuthStatus.loading
                              ? const CircularProgressIndicator()
                              : MyButton(
                                  name: "signIn".tr,
                                  onPressed: () {
                                    context.read<AuthCubit>().loginUser(
                                          email:
                                              _loginEmailController.text.trim(),
                                          password: _loginPasswordController
                                              .text
                                              .trim(),
                                        );
                                  },
                                );
                        },
                      ),
                      const SizedBox(height: 20),
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
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: Obx(() {
                              return Text(
                                'signUp'.tr,
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
                      const SizedBox(height: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state.status == AuthStatus.authenticated) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeView()));
                          }
                          if (state.status == AuthStatus.error) {
                            Get.snackbar('Error', state.failure!.message);
                            print(state.failure!.message);
                          }
                        },
                        builder: (context, state) {
                          return MyButton(
                              name: "Sign In With Google",
                              onPressed: () {
                                context.read<AuthCubit>().googleLogin();
                              });
                        },
                      ),
                      const SizedBox(height: 20),
                      MyButton(name: "Sign In With Facebook", onPressed: () {}),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
