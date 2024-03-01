import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp/features/controller/auth_controller.dart';
import 'package:whatsapp/modes/user_model.dart';
import 'package:whatsapp/widgets/chat_list.dart';

class ChatScreen extends ConsumerWidget {
  static const String routename = "chat-screen";
  final String name;
  final String uid;

  const ChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.video_call_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call))
        ],
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Column(
                children: [
                  Text(name),
                  Text(
                    snapshot.data!.isOnline ? "Online" : "Offline",
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              );
            }),
      ),
      body: Column(
        children: [
          Expanded(child: ChatList(uid)),
          BottomChatField(
            reciverUserId: uid,
          )
        ],
      ),
    );
  }
}
