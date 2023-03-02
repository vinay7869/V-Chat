import 'package:flutter/material.dart';
import 'package:whp/Chat_Widgets/chat_body.dart';

class ChatAppbar extends StatelessWidget {
  final String uid;
  final String name;
  final String profilePic;
  static const String routeName = 'chatAppbar';
  const ChatAppbar(
      {required this.name,
      required this.profilePic,
      required this.uid,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 7, top: 2, bottom: 2),
          child: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
            radius: 8,
          ),
        ),
        title: Text(name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        backgroundColor: const Color(0xff075E54),
      ),
      body: ChatBody(uid: uid,receiverId: uid),
    );
  }
}
