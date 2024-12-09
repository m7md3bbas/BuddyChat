import 'package:TaklyAPP/core/constants/failures.dart';
import 'package:TaklyAPP/features/chat/data/model/message.dart';
import 'package:TaklyAPP/features/chat/domain/usecases/get_message_use_case.dart';
import 'package:TaklyAPP/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<List<ChatMessageModel>> {
  ChatCubit(this.getMessageUseCase, this.sendMessageUseCase) : super([]);
  final GetMessageUseCase getMessageUseCase;
  final SendMessageUsecase sendMessageUseCase;

  Future<void> sendMessage({required ChatMessageModel message}) async {
    await sendMessageUseCase.call(message);
  }

  void getMessages(
      {required String senderId, required String receiverId}) async {
    getMessageUseCase
        .call(
          receiverId: senderId,
          senderId: receiverId,
        )
        .listen((event) {
          emit(event);
        });
  }
}
