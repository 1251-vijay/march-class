import 'package:chating_app/features/select_contact/controller/select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  void selectedContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectedControllerProvider)
        .selectedContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Contact"),
        ),
        body: ref.watch(selectcontroller).when(
            data: (contacList) {
              return ListView.builder(
                  itemCount: contacList.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () {
                        selectedContact(ref, contacList[index], context);
                      },
                      child: ListTile(
                        title: Text(contacList[index].displayName),
                      ),
                    );
                  });
            },
            error: (e, strackTree) => Scaffold(
                  body: Text(e.toString()),
                ),
            loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )));
  }
}
