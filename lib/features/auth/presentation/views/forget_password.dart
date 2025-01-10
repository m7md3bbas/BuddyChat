import 'package:TaklyAPP/core/widgets/mybutton.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "forgetPassword".tr,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "enterYourEmailAddressToResetYourPassword".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    type: "email".tr,
                    obscure: false,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return MyButton(
                        name: "send".tr,
                        onPressed: () {
                          context
                              .read<AuthCubit>()
                              .forgetPassword(email: emailController.text);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
