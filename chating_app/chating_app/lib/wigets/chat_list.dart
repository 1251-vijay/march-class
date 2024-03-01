import 'package:chating_app/features/chat/controller/chat_controller.dart';
import 'package:chating_app/models/messages.dart';
import 'package:chating_app/wigets/my_message_card.dart';
import 'package:chating_app/wigets/sender_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String reciverUserId;
  const ChatList(this.reciverUserId, {super.key});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messagecontoller = ScrollController();
  @override
  void dispose() {
    messagecontoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Messages>>(
        stream:
            ref.read(chatControllerProvider).getMessages(widget.reciverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messagecontoller.jumpTo(messagecontoller.position.maxScrollExtent);
          });

          return ListView.builder(
              controller: messagecontoller,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                final dateformate =
                    DateFormat.Hm().format(messageData.timeSent);

                if (!messageData.isSeen &&
                    messageData.reciverId ==
                        FirebaseAuth.instance.currentUser!.uid) {
                  ref.read(chatControllerProvider).chatMessageSeen(
                      context, widget.reciverUserId, messageData.messageId);
                }
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageCard(
                    message: messageData.text,
                    date: (dateformate),
                    seen: messageData.isSeen,
                  );
                }
                return SenderMessageCard(
                  message: messageData.text,
                  date: (dateformate),
                );
              });
        });
  }
}
