part of 'pages_navigator_bloc.dart';

sealed class PagesNavigatorEvent {
  const PagesNavigatorEvent();
}

final class OnPressedChatRoomActionButton extends PagesNavigatorEvent {}
