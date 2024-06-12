import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatelessWidget {
  final List<Contact> contacts;
  bool _isLoading = false;

  ContactsPage({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: contacts.isEmpty
          ? Center(child: Text('No contacts found'))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                contact.initials(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(contact.displayName ?? ''),
            subtitle: Text(
              contact.phones?.isNotEmpty ?? false
                  ? contact.phones!.first.value!
                  : 'No phone number',
            ),
            onTap: () {
              // Handle contact tap
            },
          );
        },
      ),
    );
  }
}
