import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

class NewChatScreen extends StatelessWidget {
  final String currentUserId;

  NewChatScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final contacts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              // Jangan tampilkan diri sendiri di daftar kontak
              if (contact.id == currentUserId) return Container();

              final userName =
                  '${contact['firstName']} ${contact['lastName'] ?? ''}';

              return ListTile(
                title: Text(userName),
                subtitle: Text(contact['email']),
                onTap: () async {
                  final chatId = await createOrGetChat(
                      currentUserId, contact.id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatId: chatId,
                        otherUserId: contact.id,
                        otherUserName: userName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<String> createOrGetChat(String currentUserId, String otherUserId) async {
    final chatRef = FirebaseFirestore.instance.collection('chats');

    // Cek apakah chat sudah ada
    final existingChat = await chatRef
        .where('users', arrayContains: currentUserId)
        .get();

    for (var doc in existingChat.docs) {
      final users = List<String>.from(doc['users']);
      if (users.contains(otherUserId)) {
        return doc.id; // Kembalikan chatId jika sudah ada
      }
    }

    // Jika belum ada, buat dokumen baru
    final newChat = await chatRef.add({
      'users': [currentUserId, otherUserId],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return newChat.id;
  }
}
