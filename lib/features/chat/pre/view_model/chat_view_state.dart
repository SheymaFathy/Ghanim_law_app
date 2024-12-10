part of 'chat_view_cubit.dart';

abstract class ChatViewState {}

class ChatViewInitial extends ChatViewState {}

class ChatLoading extends ChatViewState {}

class ChatMessageSent extends ChatViewState {
  final List<Map<String, dynamic>> messages;

  ChatMessageSent({required this.messages});
}
