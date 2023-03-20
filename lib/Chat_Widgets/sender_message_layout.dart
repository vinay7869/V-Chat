import 'package:flutter/material.dart';
import 'package:whp/Chat_Widgets/display_image_message.dart';
import 'package:whp/Common/colors.dart';
import 'package:whp/Common/enums.dart';

class SenderMessageLayout extends StatelessWidget {
  final String message;
  final String time;
  final MessageEnums type;
  const SenderMessageLayout(
      {super.key,
      required this.message,
      required this.time,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 47),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: senderMessageColor,
          // Colors.grey[700],
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Stack(children: [
            Padding(
                padding: type == MessageEnums.text
                    ? const EdgeInsets.only(
                        bottom: 15,
                        left: 10,
                        right: 40,
                        top: 5,
                      )
                    : const EdgeInsets.only(
                        bottom: 27,
                        left: 10,
                        right: 10,
                        top: 5,
                      ),
                child: DisplayImageMessage(message: message, type: type)),
            Positioned(
              bottom: 2,
              right: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(time),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
