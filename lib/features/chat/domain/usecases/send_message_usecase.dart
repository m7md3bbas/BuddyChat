
import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:TaklyAPP/features/chat/domain/repoIm/chat_repo_imp.dart';
import 'package:dartz/dartz.dart';

class SendMessageUsecase {
  final ChatRepoImp chatRepoImp;

  SendMessageUsecase({required this.chatRepoImp});

  Future<Either<Failure, void>> call(ChatMessageModel message) async =>
      await chatRepoImp.sendMessage(message);
}
