import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../messages/model/message.dart';
import '../model/conversation.dart';

class ConversationRepository {
  final FirebaseAuth _firebaseAuth;
  final DatabaseReference _databaseReference;

  ConversationRepository({
    required FirebaseAuth firebaseAuth,
    required DatabaseReference databaseReference,
  })  : _firebaseAuth = firebaseAuth,
        _databaseReference = databaseReference;

  Future<String?> startConversationWithUser(String otherUserId) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return null;

    try {
      // Create a new conversation node in the database
      final conversationRef = _databaseReference.child('conversations').push();
      final conversationId = conversationRef.key;

      // Add both users as participants to the conversation
      final participants = {
        currentUser.uid: true,
        otherUserId: true,
      };
      await conversationRef.child('participants').set(participants);

      // Return the conversationId
      return conversationId;
    } catch (e) {
      print("Error starting conversation: $e");
      return null;
    }
  }

  Future<void> sendMessage(String conversationId, String receiverId, String message) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    try {
      // Save the message to the Firebase Realtime Database
      final messageRef = _databaseReference.child('conversations').child(conversationId).child('messages').push();
      final messageId = messageRef.key;

      final messageData = {
        'senderId': currentUser.uid,
        'receiverId': receiverId,
        'text': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      await messageRef.set(messageData);
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<Conversation> getConversationStream(String conversationId) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return Stream.empty();
    }

    final conversationRef = _databaseReference.child('conversations').child(conversationId);

    return conversationRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) {
        return Conversation.empty();
      }

      final participants = data['participants'] as Map<dynamic, dynamic>?;
      final messagesData = data['messages'] as Map<dynamic, dynamic>?;

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

      return Conversation(
        id: conversationId,
        participants: participants?.keys.map((userId) => userId.toString()).toList() ?? [],
        messages: messages ?? [],
        lastMessage: messages?.last ?? Message.empty(),
      );
    });
  }
}
