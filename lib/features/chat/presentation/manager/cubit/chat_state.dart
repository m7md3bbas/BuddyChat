part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatFailure extends ChatState {
  final Failure failure;
  ChatFailure({required this.failure});
}

final class ChatLoaded extends ChatState {
  final List<ChatMessageModel> messages;
  ChatLoaded({required this.messages});
}

final class Chatloading extends ChatState {}

final class MessageSentSuccessfully extends ChatState {}
