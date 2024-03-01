// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/select_contacts/screens/contacts_repositry.dart';

final selectContactcontroller = FutureProvider((ref) {
  final selectContact = ref.watch(selectContactRepository);
  return selectContact.getcontact();
});

final selectedContactController = Provider((ref) {
  final selectContact = ref.watch(selectContactRepository);
  return SelectedContactController(
      selectContactRepository: selectContact, ref: ref);
});

class SelectedContactController {
  final SelectContactRepository selectContactRepository;
  final ProviderRef ref;
  SelectedContactController({
    required this.selectContactRepository,
    required this.ref,
  });

  void selectedContact(BuildContext context, Contact selectedContact) {
    selectContactRepository.selectedContact(context, selectedContact);
  }
}
