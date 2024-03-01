// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final bool isOnline;
  final String profilePic;
  final List<String> groupId;
  final String phoneNumber;
  final String uid;
  UserModel({
    required this.name,
    required this.isOnline,
    required this.profilePic,
    required this.groupId,
    required this.phoneNumber,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isOnline': isOnline,
      'profilePic': profilePic,
      'groupId': groupId,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map["name"] ?? "",
        isOnline: map["isOnline"] ?? false,
        profilePic: map["profilePic"] ?? "",
        groupId: List<String>.from(map["groupId"]),
        phoneNumber: map["phoneNumber"] ?? "",
        uid: map["uid"] ?? "");
  }
}
