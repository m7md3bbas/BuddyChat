import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.type,
    required this.obscure,
    this.controller,
    this.onChanged,
    this.reciverId,
    this.focusNode,
    this.suffixIcon,
    this.onTap,
    this.errortext, this.validator,
  });
  final String type;
  final bool obscure;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? reciverId;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final String? errortext;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Get.find<FontSizeController>().fontSize.value),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        focusColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: type,
        errorText: errortext,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: Get.find<FontSizeController>().fontSize.value),
      ),
    );
  }
}
