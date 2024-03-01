// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/utlis.dart';
import 'package:whatsapp/modes/user_model.dart';
import 'package:whatsapp/screens/chats_screen.dart';

final selectContactRepository = Provider((ref) =>
    SelectContactRepository(firebaseFirestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firebaseFirestore;
  SelectContactRepository({
    required this.firebaseFirestore,
  });

  Future<List<Contact>> getcontact() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      e.toString();
    }
    return contacts;
  }

  void selectedContact(BuildContext context, Contact selectedContact) async {
    try {
      var userCollection = await firebaseFirestore.collection("users").get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNumber =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (selectedPhoneNumber == userData.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, ChatScreen.routename,
              arguments: {"name": userData.name, "uid": userData.uid});
        }
      }

      if (!isFound) {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context, content: "this number doesnt exit on this app..");
      }
    } catch (e) {
      e.toString();
    }
  }
}
