import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/locator.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/core/widgets/snack_bar.dart';
import 'package:TaklyAPP/features/auth/domain/entities/user_entity.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late final TextEditingController _fNameController;

  late final TextEditingController _lNameController;

  late final TextEditingController _emailController;
  @override
  initState() {
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  String concatNames() {
    return _fNameController.text + _lNameController.text;
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            create: (context) => locator<HomeCubit>(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
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
                              controller: _fNameController,
                              obscure: false,
                              type: "firstName".tr),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 6,
                            child: MyTextField(
                                controller: _lNameController,
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
                            controller: _emailController,
                            obscure: false,
                            type: "email".tr),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        if (state.status == HomeStatus.error) {
                          GetSnacbars.errorSnackbar(state.failure!.message);
                        }
                        if (state.status == HomeStatus.loaded) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            GetSnacbars.successSnackbar("Contact added");
                            Navigator.pop(context);
                          });
                        }
                      },
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return state.status == HomeStatus.loading
                            ? const Center(child: CircularProgressIndicator())
                            : MyButton(
                                name: "save".tr,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  context.read<HomeCubit>().addContact(
                                          contactUser: UserEntity(
                                        name: concatNames(),
                                        email: _emailController.text,
                                      ));
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
