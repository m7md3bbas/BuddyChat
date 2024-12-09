
import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitConstractor.settingContractorCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
            return Text(
              'deleteAccount'.tr,
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
          },
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
              return Text(
                'are you sure you want to delete your account'.tr,
                style: TextStyle(
                  fontSize: Get.find<FontSizeController>().fontSize.value,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }),
                    const SizedBox(
                      height: 50,
                    ),
                    MyTextField(
                        type: 'password'.tr,
                        obscure: isObscured,
                        controller: passwordController,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    state is SettingsLoading
                        ? const CircularProgressIndicator()
                        : MyButton(
                            name: 'deleteAccount'.tr,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<SettingsCubit>(context)
                                  .deleteAccount(
                                      password: passwordController.text.trim());
                              Future.delayed(const Duration(seconds: 2));
                              passwordController.clear();
                            })
                  ]),
            ));
          },
        ),
      ),
    );
  }
}
