part of 'message_bloc.dart';

enum MessageStatus {
  initial,
  messageSent,
  error,
}

class MessageState extends Equatable {
  final MessageStatus status;
  final String? errorMessage;

  const MessageState._({
    this.status = MessageStatus.initial,
    this.errorMessage,
  });

  const MessageState.initial() : this._();

  const MessageState.messageSent() : this._(status: MessageStatus.messageSent);

  const MessageState.error(String errorMessage)
      : this._(status: MessageStatus.error, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, errorMessage];

  MessageState copyWith({
    MessageStatus? status,
    String? errorMessage,
  }) {
    return MessageState._(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
