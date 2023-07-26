import 'dart:async';

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

  Future<void> sendMessage({
    required String conversationId,
    required String receiverId,
    required String message,
  }) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    try {
      final messageRef = _firebaseDatabase.ref().child('conversations').child(conversationId).child('messages').push();
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
      throw e;
    }
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return [];
    }

    final conversationRef = _firebaseDatabase.ref().child('conversations').child(conversationId);
    final messagesRef = conversationRef.child('messages');

    final messagesSnapshot = await messagesRef.once();

    final messagesData = messagesSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (messagesData == null) {
      return [];
    }

    final messages = messagesData.entries.map((entry) {
      final messageData = entry.value as Map<dynamic, dynamic>;
      return Message(
        id: entry.key,
        senderId: messageData['senderId'],
        receiverId: messageData['receiverId'],
        text: messageData['text'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(messageData['timestamp']),
      );
    }).toList();

    return messages;
  }
}
