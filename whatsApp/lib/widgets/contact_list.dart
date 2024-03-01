import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/screens/chat_screen.dart';
import 'package:whatsapp/models/contact_subcollection_model.dart';
import "package:intl/intl.dart";

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).getChatContact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  final contact = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                    name: contact.name,
                                    uid: contact.contactId,
                                    profilePic: contact.profilePic,
                                  )));
                    },
                    child: ListTile(
                      title: Text(
                        contact.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        contact.lastMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(contact.profilePic),
                      ),
                      trailing: Text(
                        DateFormat.Hm().format(contact.timeSent),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}
