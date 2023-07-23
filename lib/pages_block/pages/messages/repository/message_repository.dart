import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/message.dart';

class MessageRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  MessageRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseDatabase firebaseDatabase,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseDatabase = firebaseDatabase;

  Future<void> sendMessage(String conversationId, String receiverId, String message) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    try {

      final messageRef = _firebaseDatabase.reference().child('conversations').child(conversationId).child('messages').push();
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

  Stream<List<Message>> getMessageStream(String conversationId) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return Stream.empty();
    }

    final conversationRef = _firebaseDatabase.reference().child('conversations').child(conversationId).child('messages');

    return conversationRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) {
        return [];
      }

      return data.entries.map((entry) {
        final messageData = entry.value as Map<dynamic, dynamic>;
        return Message(
          id: entry.key,
          senderId: messageData['senderId'],
          receiverId: messageData['receiverId'],
          text: messageData['text'],
          timestamp: DateTime.fromMillisecondsSinceEpoch(messageData['timestamp']),
        );
      }).toList();
    });
  }
}
