
import 'package:TaklyAPP/features/chat/data/datasource/chat_datasource.dart';
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:TaklyAPP/features/chat/data/repo/chat_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/failures.dart';

class ChatRepoImp implements ChatRepo {
  final ChatDataSourceImpl chatDataSource;

  ChatRepoImp({required this.chatDataSource});

  @override
  Stream<List<ChatMessageModel>> getChatMessages(
     { required String receiverId, required String senderId}) {
    return chatDataSource.getChatMessages(
      receiverId: receiverId,
      senderId: senderId,
    );
  }

  @override
  Future<Either<Failure, void>> sendMessage(ChatMessageModel message) async {
    try {
      final result = await chatDataSource.sendMessage(message);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
