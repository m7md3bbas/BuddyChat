import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/validtors/password_validators.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool currentIsObscure = true;
  bool newIsObscure = true;
  @override
  Widget build(BuildContext context) {
    String? password;
    return BlocProvider(
      create: (context) =>
          CubitConstractor.settingContractorCubit()..getPassword(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
            return Text(
              'updatePassword'.tr,
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
              return;
            }
            if (state is SettingGetPassword) {
              password = state.password;
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
                          type: "currentPassword".tr,
                          controller: currentPasswordController,
                          obscure: currentIsObscure,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                currentIsObscure = !currentIsObscure;
                              });
                            },
                            icon: currentIsObscure
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          )),
                      const SizedBox(height: 40),
                      MyTextField(
                        type: "newPassword".tr,
                        controller: newPasswordController,
                        obscure: newIsObscure,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                newIsObscure = !newIsObscure;
                              });
                            },
                            icon: newIsObscure
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined)),
                      ),
                      const SizedBox(height: 40),
                      state is SettingsLoading
                          ? const CircularProgressIndicator()
                          : MyButton(
                              name: "save".tr,
                              onPressed: () {
                                updateMethod(password, context);
                              })
                    ]),
              ),
            ));
          },
        ),
      ),
    );
  }

  void updateMethod(String? password, BuildContext context) {
    FocusScope.of(context).unfocus();
    try {

      if (currentPasswordController.text.trim() ==
          newPasswordController.text.trim()) {
        throw Exception(
            "New password should be different from current password");
      }
      if (PasswordValidators.validatePassword(
              newPasswordController.text.trim()) !=
          null) {
        throw Exception();
      }
      if (password != currentPasswordController.text.trim()) {
        throw Exception("Current password is incorrect");
      }
      context.read<SettingsCubit>().updatePassword(
            password: newPasswordController.text.trim(),
          );
      currentPasswordController.clear();
      newPasswordController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      currentPasswordController.clear();
      newPasswordController.clear();
    }
  }
}
