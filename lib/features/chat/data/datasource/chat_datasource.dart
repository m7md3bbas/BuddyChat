import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';



class ChatDataSourceImpl  {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  ChatDataSourceImpl();

  static const String chatsCollection = 'chats';

  Future<void> sendMessage(ChatMessageModel message) async {
    try {
      // Sender's chat collection
      final senderChatRef = firebaseFirestore
          .collection(chatsCollection)
          .doc(message.senderId)
          .collection(message.receiverId);

      // Receiver's chat collection
      final receiverChatRef = firebaseFirestore
          .collection(chatsCollection)
          .doc(message.receiverId)
          .collection(message.senderId);
      // Common data
      final messageData = {
        'message': message.content,
        'senderId': message.senderId,
        'receiverId': message.receiverId,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add message to both sender and receiver collections
      await senderChatRef.add(messageData);
      await receiverChatRef.add(messageData);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Stream<List<ChatMessageModel>> getChatMessages({required String senderId, required String receiverId}) {
    try {
      return firebaseFirestore
          .collection(chatsCollection)
          .doc(senderId)
          .collection(receiverId)
          .orderBy('timestamp', descending: true) // Order by latest messages
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatMessageModel.fromDocument(doc))
              .toList());
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message ?? "An unknown error occurred");
      return const Stream.empty(); // Safely return an empty stream
    } catch (e) {
      Get.snackbar("Error", "Unexpected error: $e");
      return const Stream.empty();
    }
  }
}
