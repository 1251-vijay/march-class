// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/common/utils/utlis.dart';
import 'package:whatsapp/enum/message_enum.dart';
import 'package:whatsapp/modes/chat_contact.dart';
import 'package:whatsapp/modes/message.dart';
import 'package:whatsapp/modes/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<List<ChatContact>> getchatcontact() {
    return firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection("users")
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
            contactId: chatContact.contactId));
      }
      return contacts;
    });
  }

  Stream<List<Message>> getMessages(String reciverUserId) {
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .orderBy("timeSent")
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  void _saveDataToContactSubCollection(
    String reciverUserId,
    String text,
    UserModel senderUserData,
    UserModel reciverUserData,
    DateTime timeSent,
  ) async {
    var reciverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        timeSent: timeSent,
        lastMessage: text,
        contactId: senderUserData.uid);

    await firestore
        .collection("users")
        .doc(reciverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(reciverChatContact.toMap());

    var senderChatContact = ChatContact(
        name: reciverUserData.name,
        profilePic: reciverUserData.profilePic,
        timeSent: timeSent,
        lastMessage: text,
        contactId: reciverUserData.uid);

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .set(senderChatContact.toMap());
  }

  _saveMessageToMessageSubcollection(
      {required String text,
      required String reciverUserId,
      required String messageId,
      required String username,
      required reciverUsername,
      required DateTime timeSent,
      required MessageEnum messagetype}) async {
    var message = Message(
        senderId: auth.currentUser!.uid,
        reciverId: reciverUsername,
        text: text,
        type: messagetype,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    //
    await firestore
        .collection("users")
        .doc(reciverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String reciverUserId,
      required UserModel senderUser}) async {
    try {
      UserModel reciverUserData;
      var timeSent = DateTime.now();
      var userDataMap =
          await firestore.collection("users").doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();
      _saveDataToContactSubCollection(
        reciverUserId,
        text,
        senderUser,
        reciverUserData,
        timeSent,
      );
      _saveMessageToMessageSubcollection(
        reciverUserId: reciverUserId,
        text: text,
        timeSent: timeSent,
        messagetype: MessageEnum.text,
        messageId: messageId,
        reciverUsername: reciverUserData.name,
        username: senderUser.name,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
  }

  void setUserState(bool isOnline) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"isOnline": isOnline});
  }
}
