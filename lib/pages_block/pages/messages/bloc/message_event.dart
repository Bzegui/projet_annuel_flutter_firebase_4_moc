import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends MessageEvent {
  final String conversationId;
  final String receiverId;
  final String message;

  const SendMessageEvent({
    required this.conversationId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object> get props => [conversationId, receiverId, message];
}

class MessageUpdatedEvent extends MessageEvent {
  final String conversationId;

  const MessageUpdatedEvent(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}
