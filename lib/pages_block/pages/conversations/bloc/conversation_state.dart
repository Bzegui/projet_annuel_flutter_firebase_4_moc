part of 'conversation_bloc.dart';

enum ConversationStatus {
  initial,
  conversationStarted,
  messageSent,
  error,
}

class ConversationState extends Equatable {
  final ConversationStatus status;
  final String? conversationId;
  final List<String> participants;
  final String? errorMessage;

  const ConversationState._({
    this.status = ConversationStatus.initial,
    this.conversationId,
    this.participants = const [],
    this.errorMessage,
  });

  const ConversationState.initial() : this._();

  const ConversationState.conversationStarted(
      String conversationId,
      List<String> participants,
      ) : this._(
    status: ConversationStatus.conversationStarted,
    conversationId: conversationId,
    participants: participants,
  );

  const ConversationState.messageSent() : this._(status: ConversationStatus.messageSent);

  const ConversationState.error(String errorMessage)
      : this._(
      status: ConversationStatus.error,
      errorMessage: errorMessage
  );

  @override
  List<Object?> get props => [
    status,
    conversationId,
    participants,
    errorMessage
  ];

  ConversationState copyWith({
    ConversationStatus? status,
    String? conversationId,
    List<String>? participants,
    String? errorMessage,
  }) {
    return ConversationState._(
      status: status ?? this.status,
      conversationId: conversationId ?? this.conversationId,
      participants: participants ?? this.participants,
      errorMessage: errorMessage,
    );
  }
}
