import 'package:TaklyAPP/features/chat/domain/entities/chat_message_entity.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.senderId,
     super.content,
    required super.receiverId,
  });

  factory ChatMessageModel.fromDocument(QueryDocumentSnapshot doc) {
    return ChatMessageModel(
      receiverId: doc.id, 
      content: doc['message'] as String,
      senderId: doc['senderId'] as String,
    );
  }

}
