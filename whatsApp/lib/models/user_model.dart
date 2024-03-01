// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String phoneNumber;
  final bool isOnline;
  final List<String> groupId;
  final String profilePic;
  UserModel({
    required this.name,
    required this.uid,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'groupId': groupId,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? "",
      uid: map['uid'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from((map['groupId'] ?? "")),
      profilePic: map['profilePic'] ?? "",
    );
  }
}
