class ChatMessageEntity {
  final String senderId;
  final String? content;
  final String receiverId;

  ChatMessageEntity({
    required this.senderId,
     this.content,
    required this.receiverId,
  });
}
