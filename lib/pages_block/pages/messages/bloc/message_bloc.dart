import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  MessageBloc({required FirebaseAuth firebaseAuth, required FirebaseDatabase firebaseDatabase})
      : _firebaseAuth = firebaseAuth,
        _firebaseDatabase = firebaseDatabase,
        super(MessageState.initial());

  @override
  Stream<MessageState> mapEventToState(
      MessageEvent event,
      ) async* {
    if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event);
    }
  }

  Stream<MessageState> _mapSendMessageEventToState(SendMessageEvent event) async* {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        yield MessageState.error("User not logged in.");
        return;
      }

      final message = {
        'senderId': currentUser.uid,
        'receiverId': event.receiverId,
        'text': event.message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Save the message to the Firebase Realtime Database
      await _firebaseDatabase.reference().child('messages').push().set(message);

      yield MessageState.messageSent();
    } catch (e) {
      yield MessageState.error("Failed to send message: $e");
    }
  }
}
