// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp/features/selecet_contacts/repository/selecet_contact_repository.dart';
import 'package:whatsapp/models/user_model.dart';

//get contacts function
final selecetcontactController = FutureProvider((ref) {
  final selectedContent = ref.watch(selecetcontanctRepository);
  return selectedContent.getContacts();
});

final selecetcontanct = Provider((ref) {
  final selecetcontanctRepositoryprovider =
      ref.watch(selecetcontanctRepository);
  return SelectController(
      selecetcontanctRepository: selecetcontanctRepositoryprovider);
});

class SelectController {
  final SelecetcontanctRepository selecetcontanctRepository;
  SelectController({
    required this.selecetcontanctRepository,
  });

  void selectContact(BuildContext context, Contact selectedContact) {
    selecetcontanctRepository.selectedcontact(selectedContact, context);
  }

  Stream<UserModel> getUserDataStatus(String userId) {
    return selecetcontanctRepository.getUserDataStatus(userId);
  }
}
