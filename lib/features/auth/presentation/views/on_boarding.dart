
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_controller.dart';
import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:TaklyAPP/core/widgets/custom_inkwell.dart';
import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/simple_inkwell.dart';
import 'package:TaklyAPP/core/widgets/theme_button.dart';
import 'package:TaklyAPP/features/auth/presentation/views/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildLanguageSelectionScreen(context),
          _buildAskMeAnythingScreen(context),
        ],
      ),
    );
  }

  Widget _buildLanguageSelectionScreen(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Select \nLanguage'.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Powerful, Convenient, Essential , \nElevate your mobile experience'
                  .tr,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            LanguageButton(localizationController: localizationController),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/chating.svg',
              height: 300,
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotIndicator(isActive: true),
                DotIndicator(isActive: false),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> completeOnboarding() async {}

  Widget _buildAskMeAnythingScreen(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Chat with \nyour friends'.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
                "Start connecting with \nyour loved ones and stay \nin touch with your friends"
                    .tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                )),
            const SizedBox(height: 20),
            const ThemeButton(),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/quick_chat.svg',
              height: 300,
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotIndicator(isActive: false),
                DotIndicator(isActive: true),
              ],
            ),
            const SizedBox(height: 20),
            MyButton(
                name: 'next'.tr,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('hasSeenOnboarding', true);
                  Get.to(() => const AuthGate());
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.localizationController,
  });

  final LocalizationController localizationController;

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
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
                          fontSize:
                              Get.find<FontSizeController>().fontSize.value,
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
                        localizationController.selectedValue.value = 'en';
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
                        localizationController.selectedValue.value = 'ar';
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
                        localizationController.selectedValue.value = 'fr';
                        LocalizationService.updateLocale(
                            'fr'); // Ensure the language is updated
                        Get.back(); // Close the bottom sheet
                      },
                    ),
                  ],
                );
              },
            ));
  }
}

class LanguageOption extends StatelessWidget {
  final String title;
  final bool value;

  const LanguageOption({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: LocalizationController()
              .selectedValue, // Replace with actual group value
          onChanged: (value) {
            // Handle radio button selection
            if (title == 'English') {
              LocalizationController().setSelected('en');
            } else if (title == 'Arabic') {
              LocalizationController().setSelected('ar');
            } else if (title == 'French') {
              LocalizationController().setSelected('fr');
            }
          },
        ),
        Text(title),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
