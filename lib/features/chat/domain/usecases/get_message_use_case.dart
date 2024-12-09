
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:TaklyAPP/features/chat/domain/repoIm/chat_repo_imp.dart';

class GetMessageUseCase {
  final ChatRepoImp chatRepoImp;
  GetMessageUseCase(this.chatRepoImp);

  Stream<List<ChatMessageModel>> call(
          {required String receiverId, required String senderId}) =>
      chatRepoImp.getChatMessages(receiverId: receiverId, senderId: senderId);
}
