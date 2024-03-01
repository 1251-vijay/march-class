import 'package:flutter/material.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/features/chat/widgets/text_image_video_gif.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard(
      {super.key,
      required this.message,
      required this.time,
      required this.type});
  final String message;
  final String time;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          color: senderMessageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessageEnum.text
                    ? const EdgeInsets.only(
                        left: 15, right: 30, bottom: 20, top: 5)
                    : const EdgeInsets.only(
                        top: 5, right: 5, bottom: 30, left: 5),
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
