part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
}

class StartConversationEvent extends ConversationEvent {
  final String otherUserId;

  const StartConversationEvent(this.otherUserId);

  @override
  List<Object?> get props => [otherUserId];
}

class SendMessageEvent extends ConversationEvent {
  final String conversationId;
  final String receiverId;
  final String message;

  const SendMessageEvent({
    required this.conversationId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object?> get props => [conversationId, receiverId, message];
}
