import 'package:equatable/equatable.dart';
import 'package:users/users_exports.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
}

class StartConversation extends ConversationEvent {
  final String otherUserId;

  StartConversation(this.otherUserId);

  @override
  List<Object?> get props => [otherUserId];
}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String receiverId;
  final String message;

  SendMessage({
    required this.conversationId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object?> get props => [conversationId, receiverId, message];
}
