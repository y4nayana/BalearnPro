// screens/chat/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/chat_provider.dart';
import '../../models/chat_message_model.dart';
import 'chat_input.dart';

class ChatScreen extends StatelessWidget {
  final String chatRoomId;

  ChatScreen({required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: chatProvider.getMessages(chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data ?? [];

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.message),
                      subtitle: Text('Sent by: ${message.senderId}'),
                    );
                  },
                );
              },
            ),
          ),
          ChatInput(
            onSendMessage: (message) async {
              final newMessage = ChatMessage(
                id: DateTime.now().toString(),
                senderId: 'user123', // Replace with current user ID
                receiverId: 'receiver123', // Replace with receiver ID
                message: message,
                timestamp: DateTime.now(),
              );
              await chatProvider.sendMessage(newMessage, chatRoomId);
            },
          ),
        ],
      ),
    );
  }
}
