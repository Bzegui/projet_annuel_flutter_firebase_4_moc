import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pages_navigator_event.dart';
part 'pages_navigator_state.dart';

class PagesNavigatorBloc extends Bloc<PagesNavigatorEvent, ChatRoomActionButtonState> {
  PagesNavigatorBloc() : super(const ChatRoomActionButtonState.pressed()) {
    on<OnPressedChatRoomActionButton>((event, emit) => emit(const ChatRoomActionButtonState.pressed()));
  }
}
