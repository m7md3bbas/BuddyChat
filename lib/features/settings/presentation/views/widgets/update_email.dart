import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/validtors/email_validator.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({super.key});

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  bool isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitConstractor.settingContractorCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
            return Text(
              'updateEmail'.tr,
              style: TextStyle(
                fontSize: Get.find<FontSizeController>().fontSize.value,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Get.back();
              }),
        ),
        body: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is SettingsFailure) {
              Get.snackbar("Error", state.failure.message);
            }
            if (state is SettingsSuccess) {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed('/login');
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextField(
                        type: "password".tr,
                        controller: UpdateEmail.passwordController,
                        obscure: isObsecured,
                        suffixIcon: IconButton(
                          icon: isObsecured
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            setState(() {
                              isObsecured = !isObsecured;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      MyTextField(
                          type: "newEmail".tr,
                          controller: UpdateEmail.emailController,
                          obscure: false),
                      const SizedBox(height: 40),
                      state is SettingsLoading
                          ? const CircularProgressIndicator()
                          : MyButton(
                              name: "save".tr,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                try {
                                  if (UpdateEmail
                                          .emailController.text.isEmpty ||
                                      UpdateEmail
                                          .passwordController.text.isEmpty) {
                                    throw Exception(
                                        "Please enter all the fields");
                                  }
                                  if (EmailValidators.validateEmail(UpdateEmail
                                          .emailController.text
                                          .trim()) !=
                                      null) {
                                    throw Exception("Please enter valid email");
                                  }
                                  context.read<SettingsCubit>().updateEmail(
                                        email: UpdateEmail.emailController.text
                                            .trim(),
                                        password: UpdateEmail
                                            .passwordController.text
                                            .trim(),
                                      );
                                  UpdateEmail.emailController.clear();
                                  UpdateEmail.passwordController.clear();
                                } catch (e) {
                                  Get.snackbar("Error", e.toString());
                                  UpdateEmail.emailController.clear();
                                  UpdateEmail.passwordController.clear();
                                }
                              })
                    ]),
              ),
            ));
          },
        ),
      ),
    );
  }
}
