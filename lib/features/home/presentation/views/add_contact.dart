import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});
  static TextEditingController fNameController = TextEditingController();
  static TextEditingController lNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Obx(() {
          return Text(
            'add_new_contact'.tr,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ),
      body: BlocProvider(
        create: (context) => CubitConstractor.homeConstractorMethod(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              Get.snackbar(
                "Error",
                state.failure.message,
              );
            }
            if (state is HomeLoaded) {
              fNameController.clear();
              lNameController.clear();
              emailController.clear();
            }
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.person,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 6,
                        child: MyTextField(
                            controller: fNameController,
                            obscure: false,
                            type: "firstName".tr),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 6,
                          child: MyTextField(
                              controller: lNameController,
                              obscure: false,
                              type: "lastName".tr)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.email,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 12,
                      child: MyTextField(
                          controller: emailController,
                          obscure: false,
                          type: "email".tr),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  state is HomeLoading
                      ? const CircularProgressIndicator()
                      : MyButton(
                          name: "save".tr,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final String fullName =
                                "${fNameController.text.trim()} ${lNameController.text.trim()}";
                            BlocProvider.of<HomeCubit>(context).addContact(
                                fullName, emailController.text.trim());
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
