// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/models/message_model.dart';
import 'package:whatsapp/widgets/my_message_Card.dart';
import 'package:whatsapp/widgets/sender_message_card.dart';

class ChatList extends ConsumerWidget {
  const ChatList({
    super.key,
    required this.reciverUserId,
  });
  final String reciverUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).getChatStreamt(reciverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });

          return ListView.builder(
              controller: scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                final message = snapshot.data![index];
                final date = DateFormat.Hm().format(message.timeSent);
                if (message.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageCard(
                    message: message.text,
                    time: date,
                    type: message.type,
                  );
                }
                return SenderMessageCard(
                  message: message.text,
                  time: date,
                  type: message.type,
                );
                // return MyMessageCard(message: messages[index], time: time)
              }));
        });
  }
}
