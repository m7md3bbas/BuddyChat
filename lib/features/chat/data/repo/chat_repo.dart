
import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Stream<List<ChatMessageModel>> getChatMessages(
      {required String senderId,required String receiverId});
  Future<Either<Failure, void>> sendMessage(ChatMessageModel message);
}
