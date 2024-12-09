
import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/simple_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitConstractor.settingContractorCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title:  Obx(() {
              return Text(
                'account'.tr,
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
        body: SafeArea(
          child: Column(
            children: [
              SimpleInkwell(
                name: 'changeName'.tr,
                icon: Icons.person,
                onTap: () => Get.toNamed('/changeName'),
              ),
              SimpleInkwell(
                  name: 'changeEmail'.tr,
                  icon: Icons.email,
                  onTap: () => Get.toNamed('/updateEmail')),
              SimpleInkwell(
                  name: 'changePassword'.tr,
                  icon: Icons.password,
                  onTap: () =>
                      Future.delayed(const Duration(milliseconds: 400), () {
                        Get.toNamed('/updatePassword');
                      })),
              SimpleInkwell(
                  name: 'deleteAccount'.tr,
                  icon: Icons.delete,
                  onTap: () => Get.toNamed('/deleteAccount')),
            ],
          ),
        ),
      ),
    );
  }
}
