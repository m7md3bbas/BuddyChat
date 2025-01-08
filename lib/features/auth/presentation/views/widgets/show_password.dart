import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowPassword extends StatelessWidget {
  const ShowPassword({
    super.key,
    required this.isObscuredNotifier,
    required this.isLogin,
  });

  final ValueNotifier<bool> isObscuredNotifier;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: isObscuredNotifier,
          builder: (context, isObscured, child) {
            return Checkbox(
              value: !isObscured,
              onChanged: (value) {
                isObscuredNotifier.value = !isObscured;
              },
            );
          },
        ),
        const Text('Show Password'),
        const Spacer(),
        isLogin
            ? GestureDetector(
                onTap: () {
                  Get.toNamed('/forgetPassword');
                },
                child: GestureDetector(
                  onTap: () => Get.toNamed('/forgetPassword'),
                  child: Obx(() {
                    return Text(
                      'forgetPassword'.tr,
                      style: TextStyle(
                        fontSize: Get.find<FontSizeController>().fontSize.value,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              )
            : Container()
      ],
    );
  }
}
