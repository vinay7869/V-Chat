import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Chat_Widgets/chat_controller.dart';
import 'package:whp/Common/common_functions.dart';
import 'package:whp/Common/enums.dart';

class ChatTextField extends ConsumerStatefulWidget {
  final String receiverId;
  const ChatTextField({required this.receiverId, super.key});

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  bool showSendButton = false;

  final _controller = TextEditingController();

  void sendMessage() {
    if (showSendButton == true) {
      ref
          .read(chatControllerProvider)
          .sendMessage(context, _controller.text.trim(), widget.receiverId);
      setState(() {
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendFileMessage(File file, MessageEnums type) {
    ref
        .read(chatControllerProvider)
        .sendImage(context, file, widget.receiverId, type);
  }

  File? image;

  void sendImage() async {
    image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image!, MessageEnums.image);
    }
  }

  void sendCameraImage(BuildContext context) async {
    image = await openCamera();
    // ignore: use_build_context_synchronously
    openDialougeBox(context);
  }

  void openDialougeBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Image'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (image != null) {
                        sendFileMessage(image!, MessageEnums.image);
                      }
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No')),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  showSendButton = false;
                }
                showSendButton = true;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Type a message',
              hintStyle: const TextStyle(color: Colors.amberAccent),
              prefixIcon: const Icon(
                Icons.emoji_emotions,
                color: Colors.white38,
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      color: Colors.white38,
                      onPressed: () {
                        sendCameraImage(context);
                      },
                      icon: const Icon(Icons.camera_alt)),
                  IconButton(
                      color: Colors.white38,
                      onPressed: sendImage,
                      icon: const Icon(Icons.attach_file_outlined)),
                ],
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(40)),
              filled: true,
              fillColor: Colors.grey.shade800,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
              onTap: sendMessage,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: showSendButton
                      ? const Icon(Icons.send, color: Colors.white)
                      : const Icon(Icons.mic, color: Colors.white))),
        )
      ],
    );
  }
}
