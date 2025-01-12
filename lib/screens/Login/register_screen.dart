import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  final PageController pageController;

  RegisterScreen({required this.pageController}); // Tambahkan parameter pageController
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); // Ganti `registerPasswordController` dengan `passwordController`
  bool isPasswordVisible = false;

  String? errorMessage;

  // Fungsi validasi input
  bool _validateInput() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = "Semua field harus diisi.";
      });
      return false;
    }

    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(emailController.text)) {
      setState(() {
        errorMessage = "Masukkan email yang valid.";
      });
      return false;
    }

    if (passwordController.text.length < 6) { // Ganti `registerPasswordController` dengan `passwordController`
      setState(() {
        errorMessage = "Password harus minimal 6 karakter.";
      });
      return false;
    }

    return true;
  }

  // Fungsi untuk registrasi
  void _register() async {
    if (!_validateInput()) return;

    try {
      // Registrasi pengguna ke Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(), // Ganti `registerPasswordController` dengan `passwordController`
      );

      // Simpan data pengguna ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi berhasil! Silahkan login.")),
      );

      // Pindahkan ke halaman login
      widget.pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } catch (e) {
      setState(() {
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            errorMessage = "Email sudah terdaftar. Silahkan gunakan email lain.";
          } else if (e.code == 'weak-password') {
            errorMessage = "Password terlalu lemah. Gunakan password yang lebih kuat.";
          } else {
            errorMessage = "Terjadi kesalahan saat registrasi.";
          }
        } else {
          errorMessage = "Terjadi kesalahan saat registrasi.";
        }
      });

      print("Error during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "Last Name",
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController, // Ganti `registerPasswordController` dengan `passwordController`
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Register", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
