// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 50,
        ),
        child: Card(
          color: const Color.fromARGB(255, 111, 107, 213),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 30, bottom: 20, top: 5),
                child: Text(
                  message,
                ),
              ),
              Positioned(
                  bottom: 3,
                  right: 10,
                  child: Text(
                    date,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 207, 203, 203)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
