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
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
            return Center(child: Text('No contacts added yet.'));
          }

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final contactId = contact['contactId'];
              final name = contact['name'];
              final email = contact['email'];

              return ListTile(
                title: Text(name),
                subtitle: Text(email),
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
