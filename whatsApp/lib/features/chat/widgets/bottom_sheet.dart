// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/common/utlis/utlis.dart';
import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class BottomTextfield extends ConsumerStatefulWidget {
  final String reciverUserId;
  const BottomTextfield({
    super.key,
    required this.reciverUserId,
  });

  @override
  ConsumerState<BottomTextfield> createState() => _BottomTextfieldState();
}

class _BottomTextfieldState extends ConsumerState<BottomTextfield> {
  final messageController = TextEditingController();
  bool isShownEndButton = false;

  void sendTextMessage() {
    if (isShownEndButton) {
      ref.read(chatControllerProvider).sendTextMessage(
          context, widget.reciverUserId, messageController.text);
      messageController.text = "";
      setState(() {});
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref
        .read(chatControllerProvider)
        .saveFileTOFirebase(context, file, widget.reciverUserId, messageEnum);
  }

  void pickedImage() async {
    File? image = await pickImageFromGallery(context);

    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void sendVideoToFirestore() {}

  void pickedVideo() async {
    File? video = await pickedVideoFromGallery();
    if (video != null) {
      // ignore: use_build_context_synchronously
      ref.read(chatControllerProvider).saveFileTOFirebase(
          context, video, widget.reciverUserId, MessageEnum.video);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            onChanged: (val) {
              if (val.isEmpty) {
                setState(() {
                  isShownEndButton = false;
                });
              } else {
                setState(() {
                  isShownEndButton = true;
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
                        icon: const Icon(Icons.emoji_emotions),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.gif))
                    ],
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: pickedImage,
                        icon: const Icon(Icons.camera_alt),
                      ),
                      IconButton(
                          onPressed: pickedVideo,
                          icon: const Icon(Icons.link_sharp))
                    ],
                  ),
                ),
                fillColor: mobileChatBoxColor,
                filled: true,
                hintText: "Message..."),
          ),
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green,
          child: InkWell(
              onTap: () {
                sendTextMessage();
              },
              child: isShownEndButton
                  ? const Icon(Icons.send)
                  : const Icon(Icons.mic)),
        )
      ],
    );
  }
}
