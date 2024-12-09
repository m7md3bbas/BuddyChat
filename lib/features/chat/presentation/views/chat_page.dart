import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_controller.dart';
import 'package:TaklyAPP/core/widgets/mytextfield.dart';
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:TaklyAPP/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  final String receiverId;
  final String name;
  final ChatCubit chatCubit;

  ChatPage({
    super.key,
    required this.receiverId,
    required this.name,
    required this.chatCubit,
  });

  static TextEditingController messageController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final LocalizationController localizationController =
      Get.put(LocalizationController());
  @override
  Widget build(BuildContext context) {
    chatCubit.getMessages(
        receiverId: receiverId, senderId: firebaseAuth.currentUser!.uid);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            name,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessageModel>>(
              stream: chatCubit.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Obx(() {
                    return Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        fontSize: Get.find<FontSizeController>().fontSize.value,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Obx(() {
                    return Text(
                      'No messages yet'.tr,
                      style: TextStyle(
                        fontSize: Get.find<FontSizeController>().fontSize.value,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }));
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data![index];
                    final isSender = message.senderId ==
                        FirebaseAuth.instance.currentUser!.uid;
                    return Align(
                      alignment: isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: isSender
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return Text(
                              message.content!,
                              style: TextStyle(
                                fontSize: Get.find<FontSizeController>()
                                    .fontSize
                                    .value,
                                color: isSender
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    type: "Type here...".tr,
                    controller: messageController,
                    obscure: false,
                  ),
                ),
                MessageIcon(
                    chatCubit: chatCubit,
                    messageController: messageController,
                    receiverId: receiverId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageIcon extends StatelessWidget {
  const MessageIcon({
    super.key,
    required this.messageController,
    required this.receiverId,
    required this.chatCubit,
  });

  final TextEditingController messageController;
  final String receiverId;
  final ChatCubit chatCubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
        FocusScope.of(context).unfocus();

        final messageText = messageController.text.trim();
        if (messageText.isEmpty) return;

        chatCubit.sendMessage(
          message: ChatMessageModel(
            senderId: FirebaseAuth.instance.currentUser!.uid,
            content: messageText,
            receiverId: receiverId,
          ),
        );
        messageController.clear();
      },
      icon: const Icon(Icons.send),
    );
  }
}
