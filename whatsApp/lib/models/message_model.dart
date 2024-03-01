// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:whatsapp/enum/enum.dart';

class Message {
  final String senderId;
  final String reciverId;
  final String text;
  final String messageId;
  final bool isSeen;
  final DateTime timeSent;
  final MessageEnum type;
  Message({
    required this.senderId,
    required this.reciverId,
    required this.text,
    required this.messageId,
    required this.isSeen,
    required this.timeSent,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'reciverId': reciverId,
      'text': text,
      'messageId': messageId,
      'isSeen': isSeen,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'type': type.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        senderId: map['senderId'] as String,
        reciverId: map['reciverId'] as String,
        text: map['text'] as String,
        messageId: map['messageId'] as String,
        isSeen: map['isSeen'] as bool,
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
        type: (map['type'] as String).toEnum());
  }
}
