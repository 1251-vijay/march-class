// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:chating_app/features/chat/repository/chat_repository.dart';
import 'package:chating_app/models/chat_contact.dart';
import 'package:chating_app/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({required this.chatRepository, required this.ref});

  void sendTextMessage(
    BuildContext context,
    String text,
    String reciverUserId,
  ) {
    ref.watch(getUserDataFirestore).whenData((value) =>
        chatRepository.sendTextMessage(context, text, reciverUserId, value!));
  }

  Stream<List<ChatContact>> getChatContact() {
    return chatRepository.getChatContact();
  }

  Stream<List<Messages>> getMessages(String reciverUserId) {
    return chatRepository.getMessages(reciverUserId);
  }

  void chatMessageSeen(BuildContext context, String recieverUserId, messageId) {
    chatRepository.setChatMessageSeen(context, recieverUserId, messageId);
  }
}
