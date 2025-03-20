import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Common/loader.dart';
import 'package:whp/Contacts/contact_controller.dart';
import '../Common/colors.dart';

class ContactScreen extends ConsumerStatefulWidget {
  static const String routeName = "/contactScreen";
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreen();
}

class _ContactScreen extends ConsumerState<ContactScreen> {
  void selectedContact(BuildContext context, Contact selectedContact) {
    ref
        .read(contactControllerProvider)
        .selectedContact(context, selectedContact);
  }

  List<Contact> result = [];
  List<Contact> finalResult = [];

  // @override
  // void initState() {
  //   finalResult = result;
  //   super.initState();
  // }

  void onSearched(String text) {
    List<Contact> myResult = [];
    if (text.isEmpty) {
      setState(() {
        myResult = result;
      });
    } else {
      myResult = result
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();

      setState(() {
        finalResult = myResult;
      });
    }
  }

  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  onChanged: (value) {
                    setState(() {
                      onSearched(value);
                    });
                  },
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search here',
                      hintStyle: TextStyle(color: Colors.white)),
                )
              : const Text('Contact list'),
          backgroundColor: appBarColor,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                icon: isSearching ? const Text('') : const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: ref.watch(contactControllerFutureProvider).when(
            data: (contactList) {
              result = contactList;
              return ListView.builder(
                itemCount: finalResult.length,
                itemBuilder: (context, index) {
                  Contact contact = finalResult[index];
                  return InkWell(
                    splashColor: Colors.green,
                    onTap: () => selectedContact(context, contact),
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
            error: (error, stackTrace) => const Center(
                  child: Text('Error'),
                ),
            loading: () => const Loader()));
  }
}
