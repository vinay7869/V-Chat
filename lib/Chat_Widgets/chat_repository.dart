import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whp/AUTH/image_provider.dart';
import 'package:whp/Common/common_functions.dart';
import 'package:whp/Common/enums.dart';
import 'package:whp/Models/chat_screen_model.dart';
import 'package:whp/Models/message_screen_model.dart';
import 'package:whp/Models/user_models.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance));

class ChatRepository {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;

  ChatRepository({required this.firebaseAuth, required this.firebaseFirestore});

  // Stream<List<MessageScreenModel>> streamMessage(String receiverId) {
  //   return firebaseFirestore
  //       .collection('users')
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .snapshots()
  //       .map((event) {
  //     List<MessageScreenModel> messages = [];
  //     for (var element in event.docs) {
  //       messages.add(MessageScreenModel.fromMap(element.data()));
  //     }
  //     return messages;
  //   });
  // }

  void saveMessageToChatScreen(String text, UserModels senderUserData,
      UserModels receiverUserData, DateTime timeSent) async {
    var senderChatScreen = ChatScreenModel(
        profilePic: receiverUserData.profilePic,
        name: receiverUserData.name,
        lastMessage: text,
        uid: receiverUserData.uid,
        timeSent: timeSent);

    await firebaseFirestore
        .collection('users')
        .doc(senderUserData.uid)
        .collection('chats')
        .doc(receiverUserData.uid)
        .set(senderChatScreen.toMap());

    var receiverChatScreen = ChatScreenModel(
        profilePic: senderUserData.profilePic,
        name: senderUserData.name,
        lastMessage: text,
        uid: senderUserData.uid,
        timeSent: timeSent);

    await firebaseFirestore
        .collection('users')
        .doc(receiverUserData.uid)
        .collection('chats')
        .doc(senderUserData.uid)
        .set(receiverChatScreen.toMap());
  }

  void saveMessageToMessageScreen({
    required String senderId,
    required String receiverName,
    required String text,
    required String receiverId,
    required DateTime timeSent,
    required String messageId,
    required MessageEnums type,
  }) async {
    var messageScreenDisplay = MessageScreenModel(
        senderId: senderId,
        receiverName: receiverName,
        messageId: messageId,
        receiverId: receiverId,
        text: text,
        timeSent: timeSent,
        type: type);

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(messageScreenDisplay.toMap());

    await firebaseFirestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(messageScreenDisplay.toMap());
  }

  void sendMessage({
    required BuildContext context,
    required String text,
    required String receiverId,
    required UserModels senderUserData,
  }) async {
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    try {
      UserModels receiverUserData;
      var userDataMap =
          await firebaseFirestore.collection('users').doc(receiverId).get();
      receiverUserData = UserModels.fromMap(userDataMap.data()!);

      saveMessageToChatScreen(
        text,
        senderUserData,
        receiverUserData,
        timeSent,
      );

      saveMessageToMessageScreen(
        senderId: senderUserData.uid,
        receiverName: receiverUserData.name,
        text: text,
        receiverId: receiverId,
        type: MessageEnums.text,
        timeSent: timeSent,
        messageId: messageId,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendImage(
      {required BuildContext context,
      required File file,
      required String receiverId,
      required UserModels senderUserData,
      required MessageEnums type,
      required ProviderRef ref}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String imageUrl = await ref.read(imageProvider).downloadImage(
          'chats/${type.type}/${senderUserData.uid}/$receiverId/$messageId',
          file);

      UserModels receiverUserData;
      var userDataMap =
          await firebaseFirestore.collection('users').doc(receiverId).get();
      receiverUserData = UserModels.fromMap(userDataMap.data()!);

      String messageType;

      switch (type) {
        case MessageEnums.image:
          messageType = '📸 image';
          break;
        case MessageEnums.video:
          messageType = '📽️ video';
          break;
        case MessageEnums.audio:
          messageType = '🎵 audio';
          break;
        case MessageEnums.gif:
          messageType = 'gif';
          break;
        default:
          messageType = 'gif';
      }

      saveMessageToChatScreen(
        messageType,
        senderUserData,
        receiverUserData,
        timeSent,
      );

      saveMessageToMessageScreen(
        senderId: senderUserData.uid,
        receiverName: receiverUserData.name,
        text: imageUrl,
        receiverId: receiverId,
        type: type,
        timeSent: timeSent,
        messageId: messageId,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
