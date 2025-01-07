// services/chat_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get messages from a specific chat room
  Stream<List<ChatMessage>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList());
  }

  // Send a new message to the chat room
  Future<void> sendMessage(ChatMessage message, String chatRoomId) async {
    try {
      await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Create a new chat room
  Future<void> createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomData) async {
    try {
      final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);
      final doc = await chatRoomRef.get();
      if (!doc.exists) {
        await chatRoomRef.set(chatRoomData);
      }
    } catch (e) {
      throw Exception('Failed to create chat room: $e');
    }
  }
}
