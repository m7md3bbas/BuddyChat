import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/widgets/simple_inkwell.dart';
import 'package:TaklyAPP/core/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSetting extends StatelessWidget {
  const ChatSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Obx(() {
            return Text(
              'chat_Settings'.tr,
              style: TextStyle(
                fontSize: Get.find<FontSizeController>().fontSize.value,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Get.back();
              })),
      body: Column(
        children: [
          const ThemeButton(),
          SimpleInkwell(
            name: 'fontSize'.tr,
            icon: Icons.text_fields,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Obx(() {
                        return Text(
                          'Select Font Size',
                          style: TextStyle(
                              fontSize: Get.find<FontSizeController>()
                                  .fontSize
                                  .value),
                        );
                      }),
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        ListTile(
                          title: Obx(() {
                            return Text(
                              'Small',
                              style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value),
                            );
                          }),
                          onTap: () {
                            Get.find<FontSizeController>()
                                .updateFontSize(14.0, context);
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: Obx(() {
                            return Text(
                              'Medium',
                              style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value),
                            );
                          }),
                          onTap: () {
                            Get.find<FontSizeController>()
                                .updateFontSize(18.0, context);
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: Obx(() {
                            return Text(
                              'Large',
                              style: TextStyle(
                                  fontSize: Get.find<FontSizeController>()
                                      .fontSize
                                      .value),
                            );
                          }),
                          onTap: () {
                            Get.find<FontSizeController>()
                                .updateFontSize(24.0, context);
                            Get.back();
                          },
                        ),
                      ])));
            },
          ),
        ],
      ),
    );
  }
}
