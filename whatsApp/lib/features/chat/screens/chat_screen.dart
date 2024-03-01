// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/features/chat/widgets/bottom_sheet.dart';
import 'package:whatsapp/features/selecet_contacts/controllers/selecet_controller.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/widgets/chat_list.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = "chat-screen";
  const ChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.profilePic,
  });
  final String name;
  final String uid;
  final String profilePic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.video_call,
                color: greyColor,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: greyColor,
              ))
        ],
        title: StreamBuilder<UserModel>(
            stream: ref.read(selecetcontanct).getUserDataStatus(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Row(
                children: [
                  CircleAvatar(
                    // backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(profilePic),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(name,
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                      Text(snapshot.data!.isOnline ? "Online" : "Offline",
                          style: const TextStyle(
                            fontSize: 10,
                          )),
                    ],
                  )
                  // Text(name,
                  //     style: const TextStyle(
                  //       fontSize: 18,
                  //     )),
                  // Text(snapshot.data!.isOnline ? "Online" : "Offline",
                  //     style: const TextStyle(
                  //       fontSize: 10,
                  //     )),
                ],
              );
            }),
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatList(
            reciverUserId: uid,
          )),
          BottomTextfield(
            reciverUserId: uid,
          )
        ],
      ),
    );
  }
}
