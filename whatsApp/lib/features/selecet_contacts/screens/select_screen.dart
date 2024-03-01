import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/selecet_contacts/controllers/selecet_controller.dart';

class SelectScreen extends ConsumerStatefulWidget {
  const SelectScreen({super.key});

  @override
  ConsumerState<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends ConsumerState<SelectScreen> {
  void selectContact(Contact selectedContact) {
    ref.read(selecetcontanct).selectContact(context, selectedContact);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
      ),
      body: ref.watch(selecetcontactController).when(data: (contactList) {
        return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              final contact = contactList[index];
              return InkWell(
                onTap: () {
                  selectContact(contact);
                },
                child: ListTile(
                  title: Text(
                    contact.displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            });
      }, error: (error, stacktree) {
        return null;
      }, loading: () {
        return null;
      }),
    );
  }
}
