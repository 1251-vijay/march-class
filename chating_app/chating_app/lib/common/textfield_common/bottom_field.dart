// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chating_app/features/chat/controller/chat_controller.dart';

class BottomField extends ConsumerStatefulWidget {
  const BottomField({
    super.key,
    required this.reciverUserId,
  });
  final String reciverUserId;

  @override
  ConsumerState<BottomField> createState() => _BottomFieldState();
}

class _BottomFieldState extends ConsumerState<BottomField> {
  final messageController = TextEditingController();
  void sendTextMessage() {
    String text = messageController.text;
    ref
        .read(chatControllerProvider)
        .sendTextMessage(context, text, widget.reciverUserId);

    setState(() {
      messageController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                  // isCollapsed: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Type a Message...",
                  // isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  filled: true,
                  fillColor: Color.fromRGBO(29, 31, 31, 1)),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 111, 107, 213),
          radius: 23,
          child: InkWell(
              onTap: () {
                sendTextMessage();
              },
              child: const Icon(Icons.send_rounded)),
        )
      ],
    );
  }
}
