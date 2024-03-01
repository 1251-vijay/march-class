// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chating_app/common/textfield_common/bottom_field.dart';
import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:chating_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:chating_app/wigets/chat_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = "chat-screen";
  const ChatScreen({
    Key? key,
    required this.message,
    required this.uid,
  }) : super(key: key);
  final String message;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: StreamBuilder<UserModel>(
            stream: ref.watch(authControllerProvider).userDataId(uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(snapshot.data!.profilePic),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        message,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        snapshot.data!.isOnline ? "online" : "offline",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatList(
            uid,
          )),
          BottomField(
            reciverUserId: uid,
          ),
        ],
      ),
    );
  }
}
