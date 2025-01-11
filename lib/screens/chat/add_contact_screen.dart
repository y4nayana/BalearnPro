import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactScreen extends StatelessWidget {
  final String currentUserId;

  AddContactScreen({required this.currentUserId});

  void addContact(BuildContext context, String contactId, String name, String email) async {
    final contactsRef = FirebaseFirestore.instance.collection('contacts');

    // Cek apakah kontak sudah ada
    final existingContact = await contactsRef
        .where('addedBy', isEqualTo: currentUserId)
        .where('contactId', isEqualTo: contactId)
        .get();

    if (existingContact.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contact already added.')),
      );
      return;
    }

    // Tambahkan kontak
    await contactsRef.add({
      'contactId': contactId,
      'name': name,
      'email': email,
      'addedBy': currentUserId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contact added successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Contact',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          if (users.isEmpty) {
            return Center(
              child: Text(
                'No users available to add.',
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              // Jangan tampilkan pengguna saat ini
              if (user.id == currentUserId) return Container();

              final name = '${user['firstName']} ${user['lastName'] ?? ''}';
              final email = user['email'];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    email,
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  trailing: Icon(Icons.person_add, color: Colors.greenAccent),
                  onTap: () {
                    addContact(context, user.id, name, email);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
