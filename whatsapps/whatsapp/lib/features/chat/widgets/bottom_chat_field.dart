// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String reciverUserId;
  const BottomChatField({
    required this.reciverUserId,
  });

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  final messagecontoller = TextEditingController();
  bool isShowEndButton = false;

  void sendTextMessage() {
    if (isShowEndButton) {
      ref.read(chatController).sendTextMessage(
          context, messagecontoller.text.trim(), widget.reciverUserId);
      setState(() {
        messagecontoller.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messagecontoller,
            onChanged: (val) {
              if (val.isEmpty) {
                setState(() {
                  isShowEndButton = false;
                });
              } else {
                setState(() {
                  isShowEndButton = true;
                });
              }
            },
            decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.gif),
                      ),
                    ],
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file_outlined),
                      ),
                    ],
                  ),
                ),
                filled: true,
                fillColor: searchBarColor,
                hintText: 'Type a Message',
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green,
            child: GestureDetector(
              onTap: sendTextMessage,
              child: isShowEndButton
                  ? const Icon(Icons.send)
                  : const Icon(Icons.mic),
            ),
          ),
        )
      ],
    );
  }
}
