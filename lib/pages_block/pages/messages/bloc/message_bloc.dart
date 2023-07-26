import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';


class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(MessageState.initial());

  @override
  Stream<MessageState> mapEventToState(
      MessageEvent event,
      ) async* {
    if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event);
    } else if (event is MessageUpdatedEvent) {
      yield* _mapMessageUpdatedEventToState(event);
    }
  }

  Stream<MessageState> _mapSendMessageEventToState(SendMessageEvent event) async* {
    yield state.copyWith(status: MessageStatus.loading);

    try {
      await messageRepository.sendMessage(
        conversationId: event.conversationId,
        receiverId: event.receiverId,
        message: event.message,
      );

      yield state.copyWith(status: MessageStatus.loaded);
    } catch (e) {
      yield state.copyWith(status: MessageStatus.error, errorMessage: 'Failed to send message');
    }
  }

  Stream<MessageState> _mapMessageUpdatedEventToState(MessageUpdatedEvent event) async* {
    try {
      final messages = await messageRepository.getMessages(event.conversationId);
      yield state.copyWith(status: MessageStatus.loaded, messages: messages);
    } catch (e) {
      yield state.copyWith(status: MessageStatus.error, errorMessage: 'Failed to fetch messages');
    }
  }
}
