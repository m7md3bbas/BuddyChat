import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/login.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/add_image.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                ),
                accountName: Obx(() {
                  return Text(
                    " state.contact!.name!",
                    style: TextStyle(
                      fontSize: Get.find<FontSizeController>().fontSize.value,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
                accountEmail: Obx(() {
                  return Text(
                    "state.contact!.email!",
                    style: TextStyle(
                      fontSize: Get.find<FontSizeController>().fontSize.value,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
                currentAccountPictureSize: const Size(130, 130)),
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
            onTap: () {},
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
            onTap: () async {
              BlocProvider.of<AuthCubit>(context).logoutUser();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              });
            },
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
