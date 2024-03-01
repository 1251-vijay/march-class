import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/modes/chat_contact.dart';
import 'package:whatsapp/screens/chats_screen.dart';

class ContactList extends ConsumerStatefulWidget {
  const ContactList({super.key});

  @override
  ConsumerState<ContactList> createState() => _ContactListState();
}

class _ContactListState extends ConsumerState<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatController).getChatContact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final contactData = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                    name: contactData.name,
                                    uid: contactData.contactId,
                                  )));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            contactData.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6, left: 5),
                            child: Text(contactData.lastMessage),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(contactData.profilePic),
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(contactData.timeSent),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
