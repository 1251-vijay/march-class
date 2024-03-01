// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chating_app/common/utlis/utlis.dart';
import 'package:chating_app/models/user_model.dart';
import 'package:chating_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedContactRepository = Provider(
    (ref) => SelectedRepository(firestore: FirebaseFirestore.instance));

class SelectedRepository {
  final FirebaseFirestore firestore;
  SelectedRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContact() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(BuildContext context, Contact selectedContact) async {
    try {
      var userDataCollection = await firestore.collection("users").get();
      bool isFound = false;
      for (var documnet in userDataCollection.docs) {
        var user = UserModel.fromMap(documnet.data());
        String selectedPhonenum =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (selectedPhonenum == user.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, ChatScreen.routeName, arguments: {
            "name": user.name,
            "uid": user.uid,
            "profilePic": user.profilePic
          });
        }
      }

      if (!isFound) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, "this number doesn't exist this app.");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
