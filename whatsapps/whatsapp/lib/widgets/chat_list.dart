import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/modes/message.dart';
import 'package:whatsapp/widgets/my_message_list.dart';
import 'package:whatsapp/widgets/sender_message.dart';

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
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatController).getMessages(widget.reciverUserId),
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
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageList(
                    message: messageData.text,
                    date: (dateformate),
                  );
                }
                return SenderMessage(
                  message: messageData.text,
                  date: (dateformate),
                );
              });
        });
  }
}
