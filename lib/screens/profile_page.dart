import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String uid;

  ProfilePage({required this.uid});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _profileImage;
  String? profileImageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          setState(() {
            firstNameController.text = userDoc['firstName'] ?? '';
            lastNameController.text = userDoc['lastName'] ?? '';
            emailController.text = userDoc['email'] ?? currentUser.email ?? '';
            profileImageUrl = userDoc['profileImageUrl'] ?? null;
          });
        }
      }
    } catch (e) {
      print("Error loading user profile: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        String? uploadedImageUrl = profileImageUrl;

        // Upload profile image if a new one is selected
        if (_profileImage != null) {
          final ref = _storage
              .ref()
              .child('profile_images')
              .child('${currentUser.uid}.jpg');
          await ref.putFile(_profileImage!);
          uploadedImageUrl = await ref.getDownloadURL();
        }

        // Save user data to Firestore
        await _firestore.collection('users').doc(currentUser.uid).set({
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
          'profileImageUrl': uploadedImageUrl,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil berhasil diperbarui")),
        );
      }
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memperbarui profil")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Pengguna',
          style: TextStyle(color: Colors.white), // Teks berwarna putih
        ),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white), // Icon warna putih
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white), // Ikon save berwarna putih
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : (profileImageUrl != null
                              ? NetworkImage(profileImageUrl!)
                              : AssetImage('assets/images/profile_pic.png'))
                                  as ImageProvider,
                      backgroundColor: Colors.redAccent.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Depan',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Belakang',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    readOnly: true, // Email tidak bisa diubah
                    decoration: InputDecoration(
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.lock, color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan logika untuk mengganti password
                      _auth.sendPasswordResetEmail(email: emailController.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email reset password telah dikirim")),
                      );
                    },
                    icon: Icon(Icons.lock, color: Colors.white), // Ikon putih
                    label: Text(
                      "Ganti Password",
                      style: TextStyle(color: Colors.white), // Teks putih
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Warna tombol merah
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}