// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/utlis.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/features/chat/screens/chat_screen.dart';

final selecetcontanctRepository = Provider(
    (ref) => SelecetcontanctRepository(firestore: FirebaseFirestore.instance));

class SelecetcontanctRepository {
  final FirebaseFirestore firestore;
  SelecetcontanctRepository({
    required this.firestore,
  });
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      // showSnackBar(context, e.toString());
    }
    return contacts;
  }

  void selectedcontact(Contact selectedContact, BuildContext context) async {
    var usercollection = await firestore.collection("users").get();
    bool isFound = false;
    for (var document in usercollection.docs) {
      var user = UserModel.fromMap(document.data());
      String phoneNumber = selectedContact.phones[0].number.replaceAll(" ", "");

      if (phoneNumber == user.phoneNumber) {
        isFound = true;
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: {
          "name": user.name,
          "uid": user.uid,
          "profilePic": user.profilePic,
        });
      }
    }
    if (!isFound) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "This number doesn't exit on this app.");
    }
  }

  Stream<UserModel> getUserDataStatus(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
