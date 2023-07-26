
import '../../messages/model/message.dart';

class Conversation {
  final String id;
  final List<String> participants;
  final List<Message> messages;
  final Message lastMessage;

  Conversation({
    required this.id,
    required this.participants,
    required this.messages,
    required this.lastMessage,
  });

  factory Conversation.empty() {
    return Conversation(
      id: '',
      participants: [],
      messages: [],
      lastMessage: Message.empty(),
    );
  }

  factory Conversation.fromSnapshot(String id, Map<dynamic, dynamic> data) {
    final participants = (data['participants'] as Map<dynamic, dynamic>)
        .keys
        .map((userId) => userId.toString())
        .toList();
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
    })?.toList() ?? [];

    final lastMessageData = data['lastMessage'] as Map<dynamic, dynamic>?;

    final lastMessage = Message(
      id: lastMessageData?['messageId'] ?? '',
      senderId: lastMessageData?['senderId'] ?? '',
      receiverId: lastMessageData?['receiverId'] ?? '',
      text: lastMessageData?['text'] ?? '',
      timestamp: lastMessageData?['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(lastMessageData?['timestamp'])
          : DateTime.now(),
    );

    return Conversation(
      id: id,
      participants: participants,
      messages: messages,
      lastMessage: lastMessage,
    );
  }
}
