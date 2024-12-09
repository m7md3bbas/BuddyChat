
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleInkwell extends StatelessWidget {
  const SimpleInkwell({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
  });
  final String name;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 30),
            Obx(() {
              return Text(
                name,
                style: TextStyle(
                  fontSize: Get.find<FontSizeController>().fontSize.value,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
