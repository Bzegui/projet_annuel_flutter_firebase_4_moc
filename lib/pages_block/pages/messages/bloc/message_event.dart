part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends MessageEvent {
  final String receiverId;
  final String message;

  const SendMessageEvent({
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object?> get props => [receiverId, message];
}
