
import 'package:TaklyAPP/core/functions/constractor_cubit.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/locator.dart';
import 'package:TaklyAPP/features/chat/data/datasource/chat_datasource.dart';
import 'package:TaklyAPP/features/chat/domain/repoIm/chat_repo_imp.dart';
import 'package:TaklyAPP/features/chat/domain/usecases/get_message_use_case.dart';
import 'package:TaklyAPP/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:TaklyAPP/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:TaklyAPP/features/chat/presentation/views/chat_page.dart';
import 'package:TaklyAPP/features/home/domain/entities/home_entities.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/delete_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Widget buildContactCard(BuildContext context, Contact contact) {
  return GestureDetector(
    onTap: () {
      Get.to(() => ChatPage(
            chatCubit: ChatCubit(
              GetMessageUseCase(ChatRepoImp(
                chatDataSource: ChatDataSourceImpl(),
              )),
              SendMessageUsecase(
                chatRepoImp: ChatRepoImp(
                  chatDataSource: ChatDataSourceImpl(),
                ),
              ),
            ),
            receiverId: contact.uid!,
            name: contact.name!,
          ));
    },
    child: Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: ListTile(
        leading:
            Icon(Icons.person, color: Theme.of(context).colorScheme.primary,size: context.width * 0.1,),
        title: Obx(() {
          return Text(
            contact.name!,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        subtitle: Obx(() {
          return Text(
            contact.email!,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          );
        }),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            showDialog(
              context: context,
              builder: (con) => BlocProvider(
                create: (context) => locator<HomeCubit>()
                  ..deleteContact(contact.email!),
                child: deleteConfirmationDialog(context, contact.email!),
              ),
            );
          },
        ),
      ),
    ),
  );
}
