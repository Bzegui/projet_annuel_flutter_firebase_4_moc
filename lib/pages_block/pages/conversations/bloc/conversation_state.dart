import 'package:equatable/equatable.dart';
import 'package:users/users_exports.dart';

import '../../messages/model/message.dart';

enum ConversationStatus { initial, loading, success, error }


class ConversationState extends Equatable {
  final String conversationId;
  final ConversationStatus status;
  final String? errorMessage;
  final List<User> participants;
  final List<Message> messages;

  ConversationState({
    required this.conversationId,
    this.status = ConversationStatus.initial,
    this.errorMessage,
    this.participants = const [],
    this.messages = const [],
  });

  ConversationState copyWith({
    String? conversationId,
    ConversationStatus? status,
    String? errorMessage,
    List<User>? participants,
    List<Message>? messages,
  }) {
    return ConversationState(
      conversationId: conversationId ?? this.conversationId,
      status: status ?? this.status,
      errorMessage: errorMessage,
      participants: participants ?? this.participants,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [conversationId, status, errorMessage, participants, messages];

}
