// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chating_app/features/select_contact/repository/select_repository.dart';

final selectcontroller = FutureProvider((ref) {
  final selectRepositry = ref.watch(selectedContactRepository);
  return selectRepositry.getContact();
});

final selectedControllerProvider = Provider((ref) {
  final selectedRepository = ref.watch(selectedContactRepository);
  return SelectedContact(selectedRepository: selectedRepository);
});

class SelectedContact {
  final SelectedRepository selectedRepository;
  SelectedContact({
    required this.selectedRepository,
  });

  void selectedContact(Contact selectedContact, BuildContext context) {
    selectedRepository.selectContact(context, selectedContact);
  }
}
