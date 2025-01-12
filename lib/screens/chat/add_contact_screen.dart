import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddContactScreen extends StatefulWidget {
  final String currentUserId;

  AddContactScreen({required this.currentUserId});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  List<String> _addedContacts = [];

  @override
  void initState() {
    super.initState();
    _fetchAddedContacts();
  }

  Future<void> _fetchAddedContacts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('addedBy', isEqualTo: widget.currentUserId)
          .get();

      setState(() {
        _addedContacts = querySnapshot.docs
            .map((doc) => doc['contactId'] as String)
            .toList();
      });
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  Future<void> _addContact(String contactId, String name) async {
    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        'addedBy': widget.currentUserId,
        'contactId': contactId,
        'name': name,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _addedContacts.add(contactId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kontak berhasil ditambahkan.')),
      );
    } catch (e) {
      print('Error adding contact: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan kontak.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Cek mode tema

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kontak'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userId = user.id;
              final name = user['firstName'] + ' ' + user['lastName'];
              final email = user['email'];

              // Skip the current user
              if (userId == widget.currentUserId) return SizedBox.shrink();

              return Card(
                color: isDarkMode ? Colors.grey[800] : Colors.white, // Warna dinamis
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black, // Warna teks dinamis
                    ),
                  ),
                  subtitle: Text(
                    email,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600], // Warna teks dinamis
                    ),
                  ),
                  trailing: _addedContacts.contains(userId)
                      ? Icon(Icons.check, color: Colors.green)
                      : IconButton(
                          icon: Icon(Icons.person_add, color: Colors.blue),
                          onPressed: () {
                            _addContact(userId, name);
                          },
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
