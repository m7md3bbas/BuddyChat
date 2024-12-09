
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/sun-and-moon.png',
            height: 40,
            width: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 30),
          Obx(() {
            return Text(
              'theme'.tr,
              style: TextStyle(
                  fontSize: Get.find<FontSizeController>().fontSize.value,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            );
          }),
          const Spacer(),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Text(
                        themeProvider.isDarkMode ? 'darkMode'.tr : 'lightMode'.tr,
                        style: TextStyle(
                          fontSize:
                              Get.find<FontSizeController>().fontSize.value,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }),
                    const SizedBox(width: 10),
                    Switch(
                      activeColor: Colors.white,
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
