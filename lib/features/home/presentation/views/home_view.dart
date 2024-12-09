import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/views/drawer.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/contact_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contexte) =>
          CubitConstractor.homeConstractorMethod()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => Get.toNamed('/drawer'),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
            return Text(
              'chats'.tr,
              style: TextStyle(
                fontSize: Get.find<FontSizeController>().fontSize.value,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          centerTitle: true,
        ),
        drawer: const BuildDrawer(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              if (FirebaseAuth.instance.currentUser == null) {
                Get.snackbar('Error', ' User not authenticated');
                FirebaseAuth.instance.signOut();
              }
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Obx(() {
                return Text(
                  state.failure.message,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }));
            } else if (state is HomeLoaded) {
              if (state.contacts == null || state.contacts!.isEmpty) {
                return Center(child: Obx(() {
                  return Text(
                    'noContactsFound'.tr,
                    style: TextStyle(
                      fontSize: Get.find<FontSizeController>().fontSize.value,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }));
              }
              return ListView.builder(
                itemCount: state.contacts!.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts![index];
                  return buildContactCard(
                    context,
                    contact,
                  );
                },
              );
            }
            return Center(child: Obx(() {
              return Text(
                'noContactsFound'.tr,
                style: TextStyle(
                  fontSize: Get.find<FontSizeController>().fontSize.value,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }));
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () async {
            await Get.toNamed('/addContact');
          },
        ),
      ),
    );
  }
}
