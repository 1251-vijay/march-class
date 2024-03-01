// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chating_app/common/utlis/utlis.dart';
import 'package:chating_app/enum/enums.dart';
import 'package:chating_app/models/chat_contact.dart';
import 'package:chating_app/models/messages.dart';
import 'package:chating_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<List<ChatContact>> getChatContact() {
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var userData = ChatContact.fromMap(document.data());
        var user =
            await firestore.collection("users").doc(userData.contactId).get();
        var userModel = UserModel.fromMap(user.data()!);
        contacts.add(ChatContact(
            name: userModel.name,
            profilePic: userModel.profilePic,
            lastMessage: userData.lastMessage,
            timeSent: userData.timeSent,
            contactId: userData.contactId));
      }
      return contacts;
    });
  }

  Stream<List<Messages>> getMessages(String reciverUserId) {
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .orderBy("timeSent")
        .snapshots()
        .map((event) {
      List<Messages> messages = [];
      for (var document in event.docs) {
        messages.add(Messages.fromMap(document.data()));
      }
      return messages;
    });
  }

  _savecontactTosubcollection({
    required UserModel senderUserData,
    required UserModel reciverUserData,
    required String text,
    required DateTime timeSent,
    required String reciverUserId,
  }) async {
    //user => reciver id  => sender id => chats => set data
    var reciverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        lastMessage: text,
        timeSent: timeSent,
        contactId: senderUserData.uid);

    await firestore
        .collection("users")
        .doc(reciverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(reciverChatContact.toMap());

    //user => sender id  => reciver id => chats => set data

    var senderChatContact = ChatContact(
        name: reciverUserData.name,
        profilePic: reciverUserData.profilePic,
        lastMessage: text,
        timeSent: timeSent,
        contactId: reciverUserData.uid);

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .set(senderChatContact.toMap());
  }

  _saveMessagesTosubcollection({
    required String text,
    required String reciverUserId,
    required DateTime timeSent,
    required String username,
    required String reciverUserName,
    required String messageId,
    required MessageEnum messageEnum,
  }) async {
    var message = Messages(
        senderId: auth.currentUser!.uid,
        reciverId: reciverUserId,
        text: text,
        messageId: messageId,
        timeSent: timeSent,
        isSeen: false,
        type: messageEnum);

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUserId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

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
    BuildContext context,
    String text,
    String reciverUserId,
    UserModel senderUserData,
  ) async {
    try {
      var timeSent = DateTime.now();
      UserModel reciverUserData;
      var userDataMap =
          await firestore.collection("users").doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();
      _savecontactTosubcollection(
        senderUserData: senderUserData,
        reciverUserId: reciverUserId,
        reciverUserData: reciverUserData,
        text: text,
        timeSent: timeSent,
      );
      _saveMessagesTosubcollection(
          text: text,
          timeSent: timeSent,
          reciverUserId: reciverUserId,
          username: senderUserData.name,
          messageEnum: MessageEnum.text,
          messageId: messageId,
          reciverUserName: reciverUserData.name);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
