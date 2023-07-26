import '../model/message.dart';

enum MessageStatus {
  initial,
  loading,
  loaded,
  error,
}

class MessageState {
  final MessageStatus status;
  final List<Message> messages;
  final String? errorMessage;

  const MessageState({
    required this.status,
    required this.messages,
    this.errorMessage,
  });

  factory MessageState.initial() {
    return const MessageState(status: MessageStatus.initial, messages: []);
  }

  MessageState copyWith({
    MessageStatus? status,
    List<Message>? messages,
    String? errorMessage,
  }) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
