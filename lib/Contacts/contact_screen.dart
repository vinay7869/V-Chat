import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Common/loader.dart';
import 'package:whp/Contacts/contact_controller.dart';
import '../Common/colors.dart';

class ContactScreen extends ConsumerWidget {
  static const String routeName = "/contactScreen";
  const ContactScreen({super.key});

  void selectedContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ref
        .read(contactControllerProvider)
        .selectedContact(context, selectedContact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact list'),
        backgroundColor: appBarColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ref.watch(contactControllerFutureProvider).when(
          data: (contactList) {
            return ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                Contact contact = contactList[index];
                return InkWell(
                  splashColor: Colors.green,
                  onTap: () => selectedContact(ref, context, contact),
                  child: ListTile(
                    leading: contact.photo == null
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('assets/wp.png'))
                        : CircleAvatar(
                            backgroundImage: MemoryImage(contact.photo!),
                          ),
                    title: Text(contact.displayName),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => const Loader(),
          loading: () => const Loader()),
    );
  }
}
