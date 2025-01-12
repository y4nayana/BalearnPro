import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'add_contact_screen.dart';

class KontakScreen extends StatelessWidget {
  final String currentUserId;

  KontakScreen({required this.currentUserId});

  Future<String> createOrGetChat(String otherUserId) async {
    final chatRef = FirebaseFirestore.instance.collection('chats');

    try {
      final existingChat = await chatRef
          .where('users', arrayContains: currentUserId)
          .get();

      for (var doc in existingChat.docs) {
        final users = List<String>.from(doc['users']);
        if (users.contains(otherUserId)) {
          return doc.id;
        }
      }

      final newChat = await chatRef.add({
        'users': [currentUserId, otherUserId],
        'lastMessage': '',
        'timestamp': FieldValue.serverTimestamp(),
      });

      return newChat.id;
    } catch (e) {
      print('Error creating or getting chat: $e');
      rethrow;
    }
  }

  Future<void> deleteContact(String contactId) async {
    try {
      final contactRef = FirebaseFirestore.instance.collection('contacts');

      final query = await contactRef
          .where('addedBy', isEqualTo: currentUserId)
          .where('contactId', isEqualTo: contactId)
          .get();

      for (var doc in query.docs) {
        await doc.reference.delete();
      }

      print('Kontak berhasil dihapus.');
    } catch (e) {
      print('Error saat menghapus kontak: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
            return Center(
              child: Text(
                'Tidak ada kontak yang tersedia.',
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
              final data = contact.data() as Map<String, dynamic>?;
              final contactId = data?['contactId'] ?? '';
              final name = data?['name'] ?? 'Unknown';
              final profileImageUrl = (data != null && data.containsKey('profileImageUrl'))
                  ? data['profileImageUrl']
                  : null;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: (profileImageUrl != null && profileImageUrl.isNotEmpty)
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: (profileImageUrl == null || profileImageUrl.isEmpty)
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chat, color: Colors.blueAccent),
                  onTap: () async {
                    try {
                      final chatId = await createOrGetChat(contactId);

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
                    } catch (e) {
                      print('Error creating or getting chat: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Terjadi kesalahan. Coba lagi nanti.')),
                      );
                    }
                  },
                  onLongPress: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Hapus Kontak'),
                          content: Text('Apakah Anda yakin ingin menghapus kontak ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await deleteContact(contactId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kontak berhasil dihapus.')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Tambah Kontak',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
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
