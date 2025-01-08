import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balearnpro2/screens/login_screen.dart'; // Pastikan path sudah sesuai

class HomeScreen extends StatelessWidget {
  final String uid; // UID dari pengguna yang login

  // Constructor untuk menerima UID pengguna
  HomeScreen({required this.uid});

  // Fungsi untuk mengambil data username pengguna dari Firestore
  Future<String> _fetchUsername() async {
    print('Fetching username for UID: $uid'); // Debug log
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      
      // Cek apakah dokumen ada dan memiliki data yang valid
      if (userDoc.exists && userDoc.data() != null) {
        print('User data: ${userDoc.data()}'); // Debug log
        return userDoc['username'] ?? 'User'; // Fallback jika username null
      } else {
        print('No user found for UID: $uid'); // Debug log
        return 'User';  // Jika tidak ditemukan, kembalikan "User"
      }
    } catch (e) {
      print('Error fetching username: $e'); // Debug log
      throw 'Failed to load username: $e';  // Menangani error jika terjadi
    }
  }

  // Fungsi untuk logout dan kembali ke halaman login
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),  // Pastikan LoginScreen sesuai path
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
        future: _fetchUsername(),  // Future untuk mengambil username dari Firestore
        builder: (context, snapshot) {
          // Tampilkan loading indicator jika masih menunggu data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Menangani error jika ada
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',  // Tampilkan error
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          // Menangani jika data tidak ada
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No username found.'));
          }

          // Menampilkan username jika data berhasil ditemukan
          return Center(
            child: Text(
              'Welcome, ${snapshot.data}!',  // Menampilkan nama pengguna
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
