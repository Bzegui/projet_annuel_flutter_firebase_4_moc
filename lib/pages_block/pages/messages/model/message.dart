import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final int timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, senderId, receiverId, text, timestamp];

  factory Message.fromMap(String id, Map<String, dynamic> data) {
    return Message(
      id: id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      text: data['text'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
