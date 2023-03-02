import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whp/Chat_Widgets/chat_textfield.dart';
import 'package:whp/Common/loader.dart';
import 'package:whp/Models/message_screen_model.dart';
import 'my_message_layout.dart';
import 'sender_message_layout.dart';

class ChatBody extends ConsumerStatefulWidget {
  final String uid;
  final String receiverId;
  const ChatBody({required this.receiverId, required this.uid, super.key});

  @override
  ConsumerState<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends ConsumerState<ChatBody> {
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;

  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image.png'), fit: BoxFit.cover)),
        child: Column(children: [
          Expanded(
            child: StreamBuilder(
                stream: firebaseFirestore
                    .collection('users')
                    .doc(firebaseAuth.currentUser!.uid)
                    .collection('chats')
                    .doc(widget.receiverId)
                    .collection('messages')
                    .orderBy('timeSent')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var contact = snapshot.data!.docs[index].data();
                        var contactInfo = MessageScreenModel.fromMap(contact);
                        if (contactInfo.senderId ==
                            firebaseAuth.currentUser!.uid) {
                          return MyMessageLayout(
                              message: contactInfo.text,
                              type: contactInfo.type,
                              time:
                                  DateFormat.jm().format(contactInfo.timeSent));
                        }
                        return SenderMessageLayout(
                            type: contactInfo.type,
                            message: contactInfo.text,
                            time: DateFormat.jm().format(contactInfo.timeSent));
                      });
                }),
          ),
          ChatTextField(receiverId: widget.uid),
        ]));
  }
}
