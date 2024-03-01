// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/features/chat/widgets/text_image_video_gif.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    Key? key,
    required this.message,
    required this.time,
    required this.type,
  }) : super(key: key);
  final String message;
  final String time;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessageEnum.text
                    ? const EdgeInsets.only(
                        left: 28, right: 30, bottom: 20, top: 5)
                    : const EdgeInsets.only(
                        right: 5, bottom: 30, left: 5, top: 5),
                child: DisplayTextImage(message: message, type: type),
              ),
              Positioned(
                  bottom: 4,
                  right: 8,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(fontSize: 13, color: greyColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        color: greyColor,
                        size: 18,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
