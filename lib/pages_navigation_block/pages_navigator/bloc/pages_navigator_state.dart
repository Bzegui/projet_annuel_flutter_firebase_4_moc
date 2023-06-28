part of 'pages_navigator_bloc.dart';

enum ChatRoomActionButtonStatus {
  pressed,
  unpressed,
}

final class ChatRoomActionButtonState extends Equatable {
  const ChatRoomActionButtonState._({
    required this.status,
  });

  const ChatRoomActionButtonState.pressed()
      : this._(status: ChatRoomActionButtonStatus.pressed);

  const ChatRoomActionButtonState.unpressed()
      : this._(status: ChatRoomActionButtonStatus.unpressed);

  final ChatRoomActionButtonStatus status;

  @override
  List<Object> get props => [status];
}