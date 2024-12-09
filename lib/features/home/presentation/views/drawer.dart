import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/add_image.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/header_fading_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => CubitConstractor.homeConstractorMethod()
        ..getname(email: FirebaseAuth.instance.currentUser!.email!),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * .30,
                    child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                        ),
                        accountName: Obx(() {
                          return Text(
                            state.contact!.name!,
                            style: TextStyle(
                              fontSize:
                                  Get.find<FontSizeController>().fontSize.value,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                        accountEmail: Obx(() {
                          return Text(
                            state.contact!.email!,
                            style: TextStyle(
                              fontSize:
                                  Get.find<FontSizeController>().fontSize.value,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                        currentAccountPicture: const AddImage(),
                        currentAccountPictureSize: const Size(130, 130)),
                  );
                }
                return const HeaderFadingDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Obx(() {
                return Text(
                  "home".tr,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              onTap: () {
                Get.toNamed("/home"); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Obx(() {
                return Text(
                  "settings".tr,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              onTap: () {
                Get.toNamed("/setting");
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Obx(() {
                return Text(
                  "logout".tr,
                  style: TextStyle(
                    fontSize: Get.find<FontSizeController>().fontSize.value,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              onTap: () {
                FirebaseAuth.instance.signOut(); // Log out user
                Get.offAllNamed('/login'); // Navigate to login screen
              },
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
