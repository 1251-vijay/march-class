// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatContact {
  final String name;
  final String profilePic;
  final DateTime timeSent;
  final String lastMessage;
  final String contactId;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.timeSent,
    required this.lastMessage,
    required this.contactId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'contactId': contactId,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? "",
      profilePic: map['profilePic'] ?? "",
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] ?? ""),
      lastMessage: map['lastMessage'] ?? "",
      contactId: map['contactId'] ?? "",
    );
  }
}
