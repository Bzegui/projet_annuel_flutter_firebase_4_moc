import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/messages/model/message.dart';

class Conversation extends Equatable {
  final String id;
  final Map<String, bool> participants;
  final String lastMessageSenderId;
  final String lastMessageReceiverId;
  final String lastMessageText;
  final int lastMessageTimestamp;

  Conversation({
    required this.id,
    required this.participants,
    required this.lastMessageSenderId,
    required this.lastMessageReceiverId,
    required this.lastMessageText,
    required this.lastMessageTimestamp, required List<Message> messages, required Map<String, Bool> lastMessage,
  });

  Conversation.empty()
      : id = '',
        participants = {},
        lastMessageSenderId = '',
        lastMessageReceiverId = '',
        lastMessageText = '',
        lastMessageTimestamp = 0;


  @override
  List<Object?> get props => [
    id,
    participants,
    lastMessageSenderId,
    lastMessageReceiverId,
    lastMessageText,
    lastMessageTimestamp,
  ];

  factory Conversation.fromMap(String id, Map<String, dynamic> data) {
    return Conversation(
      id: id,
      participants: Map<String, bool>.from(data['participants']),
      lastMessageSenderId: data['lastMessageSenderId'],
      lastMessageReceiverId: data['lastMessageReceiverId'],
      lastMessageText: data['lastMessageText'],
      lastMessageTimestamp: data['lastMessageTimestamp'], messages: [], lastMessage: {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageReceiverId': lastMessageReceiverId,
      'lastMessageText': lastMessageText,
      'lastMessageTimestamp': lastMessageTimestamp,
    };
  }
}
