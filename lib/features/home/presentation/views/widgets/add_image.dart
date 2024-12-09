import 'dart:convert';
import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddImage extends StatelessWidget {
  const AddImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitConstractor.homeConstractorMethod()
        ..getImage(
            email: FirebaseAuth
                .instance.currentUser!.email!), // Load initial image
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            return Center(
              child: Obx(() {
                return Text(
                  state.failure.message,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }),
            );
          }

          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (contextx) {
                  return AlertDialog(
                      title: Obx(() {
                        return Text(
                          'Select Option'.tr,
                          style: TextStyle(
                            fontSize:
                                Get.find<FontSizeController>().fontSize.value,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Obx(() {
                              return Text(
                                'Pick Image'.tr,
                                style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            }),
                            onTap: () {
                              BlocProvider.of<HomeCubit>(context).pickImage();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Obx(() {
                              return Text(
                                'Show Profile Image'.tr,
                                style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            }),
                            onTap: () {
                              Navigator.pop(context);
                              Get.toNamed("/PhotoProfile");
                            },
                          ),
                        ],
                      ));
                },
              );
            },
            child: CircleAvatar(
              backgroundImage: state is HomeImagePicked &&
                      state.contact!.imageUrl != null &&
                      state.contact!.imageUrl!.isNotEmpty
                  ? MemoryImage(base64Decode(state.contact!.imageUrl!))
                  : state is HomeLoaded &&
                          state.contact!.imageUrl != null &&
                          state.contact!.imageUrl!.isNotEmpty
                      ? MemoryImage(base64Decode(state.contact!.imageUrl!))
                      : null,
            ),
          );
        },
      ),
    );
  }
}
