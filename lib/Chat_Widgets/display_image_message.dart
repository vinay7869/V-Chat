import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whp/Common/enums.dart';

class DisplayImageMessage extends StatelessWidget {
  final String message;
  final MessageEnums type;
  const DisplayImageMessage(
      {required this.message, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return type == MessageEnums.text
        ? Text(
            message,
            style: const TextStyle(color: Colors.white,fontSize: 16),
          )
        : CachedNetworkImage(
            imageUrl: message,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
