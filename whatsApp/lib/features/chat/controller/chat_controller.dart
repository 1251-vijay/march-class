import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/features/auth/controllers/auth_contoller.dart';

import 'package:whatsapp/features/chat/repository/chat_repository.dart';
import 'package:whatsapp/models/contact_subcollection_model.dart';
import 'package:whatsapp/models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryprovider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
      BuildContext context, String reciverUserId, String text) {
    ref.read(getUserDataData).whenData((value) =>
        chatRepository.sendTextMessage(context, reciverUserId, text, value));
  }

  Stream<List<ChatContact>> getChatContact() {
    return chatRepository.getChatContact();
  }

  Stream<List<Message>> getChatStreamt(String reciverUserId) {
    return chatRepository.getChatStream(reciverUserId);
  }

  void saveFileTOFirebase(BuildContext context, File file, String reciverUserId,
      MessageEnum messageEnum) {
    ref.read(getUserDataData).whenData((value) =>
        chatRepository.saveFiletoFirebase(
            context: context,
            file: file,
            reciverUserId: reciverUserId,
            ref: ref,
            senderUserData: value,
            messageEnum: messageEnum));
  }
}
