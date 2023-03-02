import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/AUTH/auth_controller.dart';
import 'package:whp/Chat_Widgets/chat_repository.dart';
import 'package:whp/Common/enums.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  ChatRepository chatRepository;
  ProviderRef ref;

  ChatController({required this.ref, required this.chatRepository});

  void sendMessage(BuildContext context, String text, String receiverId) {
    ref.read(futureControllerProvider).whenData((value) {
      chatRepository.sendMessage(
        context: context,
        text: text,
        receiverId: receiverId,
        senderUserData: value!,
      );
    });
  }

  void sendImage(
      BuildContext context, File file, String receiverId, MessageEnums type) {
    ref.read(futureControllerProvider).whenData((value) {
      chatRepository.sendImage(
          context: context,
          file: file,
          receiverId: receiverId,
          senderUserData: value!,
          type: type,
          ref: ref);
    });
  }
}
