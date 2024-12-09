import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_controller.dart';
import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:TaklyAPP/core/widgets/custom_inkwell.dart';
import 'package:TaklyAPP/core/widgets/simple_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});
  static LocalizationController homeController = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Obx(() {
          return Text(
            'settings'.tr,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CustomInkwell(
              icon: Icons.key,
              title: 'account'.tr,
              subTitle:
                  '${'securitySettings'.tr} ${','.tr} ${'changePassword'.tr}',
              onTap: () => Get.toNamed('/account')),
          CustomInkwell(
              icon: Icons.chat,
              title: 'chat_Settings'.tr,
              subTitle: '${'theme'.tr} ${','.tr} ${'fontSize'.tr}',
              onTap: () => Get.toNamed('/chats')),
          CustomInkwell(
              icon: Icons.language,
              title: 'language'.tr,
              subTitle: '${'english'.tr} ${','.tr} ${'arabic'.tr}',
              onTap: () => showModalBottomSheet(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          Container(
                            height: 5,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Obx(() {
                            return Text(
                              'appLanguages'.tr,
                              style: TextStyle(
                                fontSize: Get.find<FontSizeController>()
                                    .fontSize
                                    .value,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                thickness: 1.5,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.4),
                                indent: 16,
                                endIndent: 16,
                              ),
                            ),
                          ),
                          SimpleInkwell(
                            name: 'english'.tr,
                            icon: Icons.language,
                            onTap: () {
                              // Update the selected value and close the bottom sheet
                              homeController.selectedValue.value = 'en';
                              LocalizationService.updateLocale(
                                  'en'); // Ensure the language is updated
                              Get.back(); // Close the bottom sheet
                            },
                          ),
                          SimpleInkwell(
                            name: 'arabic'.tr,
                            icon: Icons.language,
                            onTap: () {
                              // Update the selected value and close the bottom sheet
                              homeController.selectedValue.value = 'ar';
                              LocalizationService.updateLocale(
                                  'ar'); // Ensure the language is updated
                              Get.back(); // Close the bottom sheet
                            },
                          ),
                          SimpleInkwell(
                            name: 'french'.tr,
                            icon: Icons.language,
                            onTap: () {
                              // Update the selected value and close the bottom sheet
                              homeController.selectedValue.value = 'fr';
                              LocalizationService.updateLocale(
                                  'fr'); // Ensure the language is updated
                              Get.back(); // Close the bottom sheet
                            },
                          ),
                        ],
                      );
                    },
                  )),
        ],
      )),
    );
  }
}
