
import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/validtors/name_validator.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  static TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitConstractor.settingContractorCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
              return Text(
                'updateName'.tr,
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
              Get.offAllNamed('/drawer');
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
                          type: "name".tr,
                          controller: nameController,
                          obscure: false),
                      const SizedBox(height: 40),
                      state is SettingsLoading
                          ? const CircularProgressIndicator()
                          : MyButton(
                              name: "save".tr,
                              onPressed: () {
                                
                                try {
                                  if (nameController.text.isEmpty) {
                                    throw Exception("Name can't be empty");
                                  }
                                  if (NameValidators.validateName(
                                          nameController.text.trim()) !=
                                      null) {
                                    throw Exception("Invalid Name");
                                  }
                                  context.read<SettingsCubit>().updateName(
                                        name: nameController.text.trim(),
                                      );
                                  Get.snackbar(
                                      "Success", "Name changed successfully.");
                                  nameController.clear();
                                } catch (e) {
                                  Get.snackbar("Error", e.toString());
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
