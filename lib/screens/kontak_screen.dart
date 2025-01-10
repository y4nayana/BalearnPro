import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'new_chat_screen.dart';


class KontakScreen extends StatelessWidget {
  final String currentUserId;

  KontakScreen({required this.currentUserId});

  String formatTimestamp(Timestamp timestamp) {
    final DateTime date = timestamp.toDate();
    final now = DateTime.now();

    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}"; // Jam dan menit
    } else {
      return "${date.day}/${date.month}/${date.year}"; // Tanggal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: currentUserId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final chatDocs = snapshot.data!.docs;
          if (chatDocs.isEmpty) {
            return Center(child: Text('No chats yet.'));
          }

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              final chat = chatDocs[index];
              final otherUserId = (chat['users'] as List)
                  .firstWhere((uid) => uid != currentUserId);

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  final userData = userSnapshot.data!;
                  final userName = userData['firstName'] +
                      ' ' +
                      (userData['lastName'] ?? '');

                  final lastMessage = chat['lastMessage'] ?? '';
                  final timestamp = chat['timestamp'] as Timestamp;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(userName[0]),
                    ),
                    title: Text(userName),
                    subtitle: Text(
                      lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(formatTimestamp(timestamp)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chat.id,
                            otherUserId: otherUserId,
                            otherUserName: userName,
                          ),
                        ),
                      );
                    },
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
          // Arahkan ke layar untuk membuat chat baru
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewChatScreen(currentUserId: currentUserId),
            ),
          );
        },
      ),
    );
  }
}
