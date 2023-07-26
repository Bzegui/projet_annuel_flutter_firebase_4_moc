import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../messages/model/message.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  ConversationBloc({
    required FirebaseAuth firebaseAuth,
    required FirebaseDatabase firebaseDatabase,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseDatabase = firebaseDatabase,
        super(ConversationState(conversationId: ''));

  @override
  Stream<ConversationState> mapEventToState(ConversationEvent event) async* {
    if (event is StartConversation) {
      yield* _mapStartConversationToState(event);
    } else if (event is SendMessage) {
      yield* _mapSendMessageToState(event);
    }
  }

  Stream<ConversationState> _mapStartConversationToState(StartConversation event) async* {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      yield state.copyWith(status: ConversationStatus.error, errorMessage: 'User not authenticated.');
      return;
    }

    try {
      final conversationRef = _firebaseDatabase.ref().child('conversations').push();
      final conversationId = conversationRef.key;

      // Add both users as participants to the conversation
      final participants = {
        currentUser.uid: true,
        event.otherUserId: true,
      };
      await conversationRef.child('participants').set(participants);

      // Return the conversationId
      yield state.copyWith(conversationId: conversationId, status: ConversationStatus.success);
    } catch (e) {
      yield state.copyWith(status: ConversationStatus.error, errorMessage: 'Error starting conversation.');
    }
  }

  Stream<ConversationState> _mapSendMessageToState(SendMessage event) async* {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      yield state.copyWith(status: ConversationStatus.error, errorMessage: 'User not authenticated.');
      return;
    }

    try {
      // Save the message to the Firebase Realtime Database
      final messageRef = _firebaseDatabase.ref().child('conversations').child(event.conversationId).child('messages').push();
      final messageId = messageRef.key;

      final messageData = {
        'senderId': currentUser.uid,
        'receiverId': event.receiverId,
        'text': event.message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      await messageRef.set(messageData);

      // Reload the conversation data after sending the message
      yield state.copyWith(status: ConversationStatus.loading);
      String? conversationId = state.conversationId;

      yield await _reloadConversationData(state.conversationId);
    } catch (e) {
      yield state.copyWith(status: ConversationStatus.error, errorMessage: 'Error sending message.');
    }
  }

  Future<ConversationState> _reloadConversationData(String conversationId) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return state.copyWith(status: ConversationStatus.error, errorMessage: 'User not authenticated.');
    }

    final conversationRef = _firebaseDatabase.ref().child('conversations').child(conversationId);
    final conversationSnapshot = await conversationRef.once();

    final data = conversationSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data == null) {
      return state.copyWith(status: ConversationStatus.error, errorMessage: 'Conversation not found.');
    }

    final participants = data['participants'] ;//as Map<dynamic, dynamic>?;
    final messagesData = data['messages'] ;// as Map<dynamic, dynamic>?;

    final messages = messagesData?.entries.map((entry) {
      final messageData = entry.value as Map<dynamic, dynamic>;
      return Message(
        id: entry.key,
        senderId: messageData['senderId'],
        receiverId: messageData['receiverId'],
        text: messageData['text'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(messageData['timestamp']),
      );
    })?.toList();

    return state.copyWith(
      participants: participants,// ?.keys.map((userId) => userId.toString()).toList() ?? [],
      messages: messages ?? [],
      status: ConversationStatus.success,
    );
  }
}
