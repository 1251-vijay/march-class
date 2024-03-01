// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp/enum/enum.dart';
import 'package:whatsapp/features/chat/widgets/video_player.dart';

class DisplayTextImage extends StatelessWidget {
  const DisplayTextImage({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);
  final String message;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(message, style: const TextStyle(fontSize: 15))
        : type == MessageEnum.video
            ? VideoPlayerScreen(videoUrl: message)
            : CachedNetworkImage(imageUrl: message);
  }
}
