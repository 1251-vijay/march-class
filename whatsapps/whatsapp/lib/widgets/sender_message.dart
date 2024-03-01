import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/colors.dart';

class SenderMessage extends StatelessWidget {
  final String message;
  final String date;

  const SenderMessage({super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            // topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          color: senderMessageColor,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 13, right: 30, bottom: 20, top: 3),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Positioned(
                  bottom: 2,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
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
