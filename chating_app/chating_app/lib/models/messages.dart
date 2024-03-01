// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chating_app/enum/enums.dart';

class Messages {
  final String senderId;
  final String reciverId;
  final String text;
  final String messageId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageEnum type;
  Messages({
    required this.senderId,
    required this.reciverId,
    required this.text,
    required this.messageId,
    required this.timeSent,
    required this.isSeen,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'reciverId': reciverId,
      'text': text,
      'messageId': messageId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'type': type.type,
    };
  }

  factory Messages.fromMap(Map<String, dynamic> map) {
    return Messages(
      senderId: map['senderId'] ?? "",
      reciverId: map['reciverId'] ?? '',
      text: map['text'] ?? "",
      messageId: map['messageId'] ?? "",
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] ?? ""),
      isSeen: map['isSeen'] ?? false,
      type: (map['type'] as String).toEnum(),
    );
  }
}
