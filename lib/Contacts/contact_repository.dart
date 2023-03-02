import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Chat_Widgets/chat_appbar.dart';
import 'package:whp/Common/common_functions.dart';
import 'package:whp/Models/user_models.dart';

final contactRepositoryProvider = Provider(
  (ref) => ContactRepository(firebaseFirestore: FirebaseFirestore.instance),
);

class ContactRepository {
  FirebaseFirestore firebaseFirestore;

  ContactRepository({required this.firebaseFirestore});

  Future<List<Contact>> getUserContact() async {
    List<Contact> contact = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contact = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true, withThumbnail: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contact;
  }

  void selectedContact(BuildContext context, Contact selectedContact) async {
    try {
      var userCollection = await firebaseFirestore.collection('users').get();
      bool isFound = false;

      for (var element in userCollection.docs) {
        var userData = UserModels.fromMap(element.data());
        String selectedPhonenumber =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhonenumber == userData.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, ChatAppbar.routeName, arguments: {
            'name': userData.name,
            'uid': userData.uid,
            'profilePic': userData.profilePic
          });
        }
      }
      if (isFound == false) {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context,
            content: 'This number is not registered with this app');
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
