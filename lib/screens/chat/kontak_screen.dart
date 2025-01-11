import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'add_contact_screen.dart';

class KontakScreen extends StatelessWidget {
  final String currentUserId;

  KontakScreen({required this.currentUserId});

  Future<String> createOrGetChat(String otherUserId) async {
    final chatRef = FirebaseFirestore.instance.collection('chats');

    // Periksa apakah chat sudah ada
    final existingChat = await chatRef
        .where('users', arrayContains: currentUserId)
        .get();

    for (var doc in existingChat.docs) {
      final users = List<String>.from(doc['users']);
      if (users.contains(otherUserId)) {
        return doc.id; // Jika sudah ada, kembalikan chatId
      }
    }

    // Jika belum ada, buat dokumen chat baru
    final newChat = await chatRef.add({
      'users': [currentUserId, otherUserId],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return newChat.id;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('contacts')
              .where('addedBy', isEqualTo: currentUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final contacts = snapshot.data!.docs;

            if (contacts.isEmpty) {
              return Center(
                child: Text(
                  'No contacts added yet.',
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final contactId = contact['contactId'];
                final name = contact['name'];
                final email = contact['email'];

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
                    trailing: Icon(Icons.chat, color: Colors.blueAccent),
                    onTap: () async {
                      // Dapatkan atau buat chatId untuk kontak ini
                      final chatId = await createOrGetChat(contactId);

                      // Navigasikan ke ChatScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chatId,
                            otherUserId: contactId,
                            otherUserName: name,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Contact',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.person_add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(currentUserId: currentUserId),
            ),
          );
        },
      ),
    );
  }
}
