import 'package:flutter/material.dart';
import 'package:whp/Chat_Widgets/display_image_message.dart';
import 'package:whp/Common/colors.dart';
import 'package:whp/Common/enums.dart';

class MyMessageLayout extends StatelessWidget {
  final String message;
  final String time;
  final MessageEnums type;
  const MyMessageLayout(
      {super.key,
      required this.type,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Stack(children: [
            Padding(
                padding: type == MessageEnums.text
                    ? const EdgeInsets.only(
                        bottom: 18,
                        left: 10,
                        right: 60,
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
                  const Icon(
                    size: 20,
                    Icons.done_all,
                    color: Colors.blueAccent,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
