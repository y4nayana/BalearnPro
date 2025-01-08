import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

class HomePage extends StatelessWidget {
  final String uid;

  HomePage({required this.uid});

  Future<String> _fetchUsername() async {
    print('Fetching username for UID: $uid'); // Debug log
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        print('User data: ${userDoc.data()}'); // Debug log
        return userDoc['username'] ?? 'User'; // Fallback jika username null
      } else {
        print('No user found for UID: $uid'); // Debug log
        return 'User';
      }
    } catch (e) {
      print('Error fetching username: $e'); // Debug log
      throw 'Failed to load username: $e';
    }
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _fetchUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No username found.'));
          }
          return Center(
            child: Text(
              'Welcome, ${snapshot.data}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
