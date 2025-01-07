// screens/contact/contact_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/contact_provider.dart';
import '../../models/contact_model.dart';
import 'add_contact_screen.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContactScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: contactProvider.fetchContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (contactProvider.contacts.isEmpty) {
            return Center(child: Text('No contacts found.'));
          }

          return ListView.builder(
            itemCount: contactProvider.contacts.length,
            itemBuilder: (context, index) {
              final contact = contactProvider.contacts[index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phoneNumber),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    contactProvider.deleteContact(contact.id);
                  },
                ),
                onTap: () {
                  // Optional: Handle contact tap for viewing or editing
                },
              );
            },
          );
        },
      ),
    );
  }
}
