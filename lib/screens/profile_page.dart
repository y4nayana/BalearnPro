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

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _profileImage;
  String? profileImageUrl;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

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
      final userDoc = await _firestore.collection('users').doc(widget.uid).get();
      if (userDoc.exists) {
        setState(() {
          firstNameController.text = userDoc['firstName'] ?? '';
          lastNameController.text = userDoc['lastName'] ?? '';
          emailController.text = userDoc['email'] ?? '';
          profileImageUrl = userDoc['profileImageUrl'];
        });
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

  Future<void> _uploadProfileImage() async {
    if (_profileImage != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${widget.uid}.jpg');
      await ref.putFile(_profileImage!);
      profileImageUrl = await ref.getDownloadURL();
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _uploadProfileImage();

      await _firestore.collection('users').doc(widget.uid).update({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'profileImageUrl': profileImageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profil berhasil diperbarui")),
      );

      // Navigasi kembali ke halaman sebelumnya (Home)
      Navigator.pop(context, {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'profileImageUrl': profileImageUrl,
      });
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

  Future<void> _changePassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email reset password telah dikirim")),
      );
    } catch (e) {
      print("Error sending password reset email: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim email reset password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
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
                              : AssetImage('assets/images/default_profile.png')) as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _changePassword,
                    icon: Icon(Icons.lock),
                    label: Text("Ganti Password"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
