// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/chat/repository/chat_repository.dart';
import 'package:whatsapp/features/controller/auth_controller.dart';
import 'package:whatsapp/modes/chat_contact.dart';
import 'package:whatsapp/modes/message.dart';

final chatController = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> getChatContact() {
    return chatRepository.getchatcontact();
  }

  void setUserData(bool isOnline) {
    chatRepository.setUserState(isOnline);
  }

  Stream<List<Message>> getMessages(String reciverUserId) {
    return chatRepository.getMessages(reciverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String reciverUserId,
  ) {
    ref.read(getuserprovider).whenData((value) {
      return chatRepository.sendTextMessage(
          context: context,
          text: text,
          reciverUserId: reciverUserId,
          senderUser: value!);
    });
  }
}
