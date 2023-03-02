import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:whp/Chat_Widgets/chat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:whp/Common/loader.dart';
import 'package:whp/Models/chat_screen_model.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;

  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection('chats')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var contact = snapshot.data!.docs[index].data();
              var contactInfo = ChatScreenModel.fromMap(contact);
              return InkWell(
                onTap: () => Navigator.pushNamed(context, ChatAppbar.routeName,
                    arguments: {
                      'name': contactInfo.name,
                      'uid': contactInfo.uid,
                      'profilePic': contactInfo.profilePic
                    }),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contactInfo.profilePic),
                    radius: 20,
                  ),
                  title: Text(contactInfo.name),
                  subtitle: Text(contactInfo.lastMessage),
                  trailing: Text(DateFormat.Hm().format(contactInfo.timeSent),
                      style: const TextStyle(fontSize: 12)),
                ),
              );
            },
          );
        });
  }
}
