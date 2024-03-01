import 'package:chating_app/features/chat/controller/chat_controller.dart';
import 'package:chating_app/models/chat_contact.dart';
import 'package:chating_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ChatContact>>(
        stream: ref.read(chatControllerProvider).getChatContact(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatScreen(
                              message: data.name, uid: data.contactId)));
                },
                child: ListTile(
                  title: Text(data.name),
                  subtitle: Text(data.lastMessage),
                  trailing: Text(DateFormat.Hm().format(data.timeSent)),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(data.profilePic),
                  ),
                ),
              );
            },
          );
        });
  }
}
