// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/common/utlis/utlis.dart';
import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/models/contact_subcollection_model.dart';
import 'package:whatsapp/models/message_model.dart';
import 'package:whatsapp/models/user_model.dart';

final chatRepositoryprovider = Provider((ref) => ChatRepository(
    fireStore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.fireStore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContact() {
    return fireStore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await fireStore
            .collection("users")
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            lastMessage: chatContact.lastMessage,
            profilePic: user.profilePic,
            timeSent: chatContact.timeSent,
            contactId: chatContact.contactId));
      }
      return contacts;
    });
  }

  Stream<List<Message>> getChatStream(String reciverUserId) {
    return fireStore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .orderBy("timeSent")
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var documnet in event.docs) {
        // var user = Message.fromMap(documnet.data());
        messages.add(Message.fromMap(documnet.data()));
      }
      return messages;
    });
  }

  _saveDataContactSubcollection({
    required UserModel senderUserData,
    required UserModel reciverUserData,
    required String text,
    required String reciverUserId,
    required DateTime timeSent,
  }) async {
    var reciverChatContact = ChatContact(
        name: senderUserData.name,
        lastMessage: text,
        profilePic: senderUserData.profilePic,
        timeSent: timeSent,
        contactId: senderUserData.uid);

    await fireStore
        .collection("users")
        .doc(reciverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(reciverChatContact.toMap());

    var senderContact = ChatContact(
        name: reciverUserData.name,
        lastMessage: text,
        profilePic: reciverUserData.profilePic,
        timeSent: timeSent,
        contactId: reciverUserData.uid);

    await fireStore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .set(senderContact.toMap());
  }

  _saveMessageToMessageSubcollectiom({
    required String reciverUserId,
    required String userName,
    required String text,
    required String reciverUserName,
    required DateTime timeSent,
    required String messageId,
    required MessageEnum messagetype,
  }) async {
    var message = Message(
        senderId: auth.currentUser!.uid,
        reciverId: reciverUserId,
        text: text,
        messageId: messageId,
        isSeen: false,
        timeSent: timeSent,
        type: messagetype);

    await fireStore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    await fireStore
        .collection("users")
        .doc(reciverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage(BuildContext context, String reciverUserId, String text,
      UserModel sendUser) async {
    try {
      var timeSent = DateTime.now();
      UserModel reciverUserData;
      var userCollection =
          await fireStore.collection("users").doc(reciverUserId).get();
      var messageId = const Uuid().v1();
      reciverUserData = UserModel.fromMap(userCollection.data()!);
      _saveDataContactSubcollection(
        senderUserData: sendUser,
        reciverUserId: reciverUserId,
        timeSent: timeSent,
        reciverUserData: reciverUserData,
        text: text,
      );
      _saveMessageToMessageSubcollectiom(
        timeSent: timeSent,
        reciverUserId: reciverUserId,
        messageId: messageId,
        text: text,
        reciverUserName: reciverUserData.name,
        userName: sendUser.name,
        messagetype: MessageEnum.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void saveFiletoFirebase({
    required BuildContext context,
    required File file,
    required String reciverUserId,
    required ProviderRef ref,
    required UserModel senderUserData,
    required MessageEnum messageEnum,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      String imageurl = await ref.read(commonAuthRepository).storeFileToFirebase(
          "chat/${messageEnum.type}/${senderUserData.uid}/$reciverUserId/$messageId",
          file);
      UserModel reciverUserData;
      var userDataMap =
          await fireStore.collection("users").doc(reciverUserId).get();

      reciverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataContactSubcollection(
          reciverUserData: reciverUserData,
          senderUserData: senderUserData,
          reciverUserId: reciverUserId,
          text: contactMsg,
          timeSent: timeSent);

      _saveMessageToMessageSubcollectiom(
          reciverUserId: reciverUserId,
          userName: senderUserData.name,
          text: imageurl,
          reciverUserName: reciverUserData.name,
          timeSent: timeSent,
          messageId: messageId,
          messagetype: messageEnum);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
