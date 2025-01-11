import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/views/home_view.dart';
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
  late final TextEditingController _registerfNameController;
  late final TextEditingController _registerEmailController;
  late final TextEditingController _registerPasswordController;
  late final TextEditingController _registerConfirmPasswordController;
  bool _registerisobscure = true;
  final _registerFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    _registerfNameController = TextEditingController();
    _registerEmailController = TextEditingController();
    _registerPasswordController = TextEditingController();
    _registerConfirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _registerfNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.status == AuthStatus.authenticated) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()));
                      }
                      if (state.status == AuthStatus.error) {
                        Get.snackbar('Error', state.failure!.message);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: _registerFormKey,
                          child: Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat,
                                size: Get.find<FontSizeController>()
                                        .fontSize
                                        .value *
                                    5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Obx(() {
                                return Text(
                                  'signUp'.tr,
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
                              MyTextField(
                                controller: _registerfNameController,
                                obscure: false,
                                type: "firstName".tr,
                              ),
                              MyTextField(
                                controller: _registerEmailController,
                                obscure: false,
                                type: "email".tr,
                              ),
                              MyTextField(
                                type: 'Password',
                                controller: _registerPasswordController,
                                obscure: _registerisobscure,
                              ),
                              MyTextField(
                                type: 'confirm Password',
                                controller: _registerConfirmPasswordController,
                                obscure: _registerisobscure,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: !_registerisobscure,
                                    onChanged: (value) {
                                      setState(() {
                                        _registerisobscure =
                                            !_registerisobscure;
                                      });
                                    },
                                  ),
                                  const Text('Show Password'),
                                  const Spacer(),
                                ],
                              ),
                              BlocBuilder<AuthCubit, AuthState>(
                                buildWhen: (previous, current) =>
                                    previous != current,
                                builder: (context, state) {
                                  return state.status == AuthStatus.loading
                                      ? const CircularProgressIndicator()
                                      : MyButton(
                                          name: "signUp".tr,
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .registerUser(
                                                  email:
                                                      _registerEmailController
                                                          .text,
                                                  password:
                                                      _registerPasswordController
                                                          .text,
                                                  name: _registerfNameController
                                                      .text,
                                                  confirmPassword:
                                                      _registerConfirmPasswordController
                                                          .text,
                                                );
                                          },
                                        );
                                },
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Obx(() {
                                      return Text(
                                        "signIn".tr,
                                        style: TextStyle(
                                            fontSize:
                                                Get.find<FontSizeController>()
                                                    .fontSize
                                                    .value,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )));
  }
}
