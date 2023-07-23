import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ConversationBloc({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        super(const ConversationState.initial());

  @override
  Stream<ConversationState> mapEventToState(
      ConversationEvent event,
      ) async* {
    if (event is StartConversationEvent) {
      yield* _mapStartConversationEventToState(event);
    } else if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event);
    }
  }

  Stream<ConversationState> _mapStartConversationEventToState(
      StartConversationEvent event) async* {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        yield const ConversationState.error("User not logged in.");
        return;
      }

      final conversationRef = _firestore.collection('conversations').doc();
      final conversationId = conversationRef.id;
      final participants = [currentUser.uid, event.otherUserId];

      await conversationRef.set({
        'participants': participants.fold<Map<String, bool>>({}, (map, id) {
          map[id] = true;
          return map;
        }),
      });

      yield ConversationState.conversationStarted(
          conversationId,
          participants
      );
    } catch (e) {
      yield ConversationState.error("Failed to start conversation: $e");
    }
  }

  Stream<ConversationState> _mapSendMessageEventToState(
      SendMessageEvent event) async* {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        yield const ConversationState.error("User not logged in.");
        return;
      }


      final conversationRef = _firestore.collection(
          'conversations').
      doc(event.conversationId);
      final conversationSnapshot = await conversationRef.get();
      if (!conversationSnapshot.exists) {
        yield const ConversationState.error("Conversation not found.");
        return;
      }


      final participants = List<String>.from(
          conversationSnapshot[
            'participants'
          ].keys);

      if (!participants.contains(
          currentUser.uid)) {
        yield const ConversationState.error("You are not a participant in this conversation.");
        return;
      }
      final message = {
        'senderId': currentUser.uid,
        'receiverId': event.receiverId,
        'text': event.message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await conversationRef.collection('messages').add(message);

      yield const ConversationState.messageSent();
    } catch (e) {
      yield ConversationState.error("Failed to send message: $e");
    }
  }
}
