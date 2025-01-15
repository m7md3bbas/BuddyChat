// import 'dart:convert';

// import 'package:TaklyAPP/core/functions/font_size_controller.dart';
// import 'package:TaklyAPP/core/functions/locator.dart';
// import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
// import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// class ProfilePhoto extends StatelessWidget {
//   const ProfilePhoto({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => locator<HomeCubit>(),
//       child: Scaffold(
//         appBar: AppBar(
//             title: Obx(() {
//               return Text(
//                 'Profile Photo',
//                 style: TextStyle(
//                   fontSize: Get.find<FontSizeController>().fontSize.value,
//                   color: Theme.of(context).colorScheme.primary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             }),
//             backgroundColor: Theme.of(context).colorScheme.secondary),
//         body: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             return SafeArea(
//                 child: Center(
//               child: state.status == HomeStatus.loaded
//                   ? Image.memory(
//                       base64Decode(state.contact!.imageUrl!),
//                       fit: BoxFit.fill,
//                       width: double.infinity,
//                     )
//                   : state is HomeLoading
//                       ? const CircularProgressIndicator()
//                       : state is HomeError
//                           ? Obx(() {
//                               return Text(
//                                 state.failure.message,
//                                 style: TextStyle(
//                                   fontSize: Get.find<FontSizeController>()
//                                       .fontSize
//                                       .value,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               );
//                             })
//                           : Image.asset('assets/images/male_avatar.png'),
//             ));
//           },
//         ),
//       ),
//     );
//   }
// }
