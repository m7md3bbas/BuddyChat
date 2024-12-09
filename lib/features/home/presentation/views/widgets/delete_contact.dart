import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Widget deleteConfirmationDialog(BuildContext context, String email) {
  return AlertDialog(
    title: Obx(() {
      return Text(
        'deleteContact'.tr,
        style: TextStyle(
          fontSize: Get.find<FontSizeController>().fontSize.value,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      );
    }),
    content: Obx(() {
      return Text(
        'are you sure you want to delete this contact'.tr,
        style: TextStyle(
          fontSize: Get.find<FontSizeController>().fontSize.value,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Obx(() {
          return Text(
            'cancel'.tr,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Close the dialog
          BlocProvider.of<HomeCubit>(context).deleteContact(email);
        },
        child: Obx(() {
          return Text(
            'delete'.tr,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }),
      ),
    ],
  );
}
