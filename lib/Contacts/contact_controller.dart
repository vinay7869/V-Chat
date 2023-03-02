import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Contacts/contact_repository.dart';

final contactControllerFutureProvider = FutureProvider(
  (ref) {
    final contactRepository = ref.watch(contactRepositoryProvider);
    return contactRepository.getUserContact();
  },
);

final contactControllerProvider = Provider(
  (ref) {
    final contactRepository = ref.watch(contactRepositoryProvider);
    return ContactController(contactRepository: contactRepository);
  },
);

class ContactController {
  ContactRepository contactRepository;

  ContactController({required this.contactRepository});

  void selectedContact(BuildContext context, Contact selectedContact) {
    contactRepository.selectedContact(context, selectedContact);
  }
}
