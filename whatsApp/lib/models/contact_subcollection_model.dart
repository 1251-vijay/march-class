// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatContact {
  final String name;
  final String lastMessage;
  final String profilePic;
  final DateTime timeSent;
  final String contactId;
  ChatContact({
    required this.name,
    required this.lastMessage,
    required this.profilePic,
    required this.timeSent,
    required this.contactId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastMessage': lastMessage,
      'profilePic': profilePic,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'contactId': contactId,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      lastMessage: map['lastMessage'] as String,
      profilePic: map['profilePic'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      contactId: map['contactId'] as String,
    );
  }
}
