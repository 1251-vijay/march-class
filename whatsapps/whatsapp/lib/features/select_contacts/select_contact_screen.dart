import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/select_contacts/screens/repository/controller/contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  const SelectContactScreen({super.key});

  void selectedContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ref
        .read(selectedContactController)
        .selectedContact(context, selectedContact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(selectContactcontroller).when(
          data: (contactList) {
            return ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () {
                      selectedContact(ref, context, contact);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: ListTile(
                        title: Text(contact.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: MemoryImage(contact.photo!),
                              ),
                      ),
                    ),
                  );
                });
          },
          error: ((error, stackTrace) => null),
          loading: () => null),
    );
  }
}
