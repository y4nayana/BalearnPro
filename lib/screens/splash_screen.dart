import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';  // Pastikan sudah sesuai
import 'Login/login_screen.dart'; // Pastikan sudah sesuai

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(context);  // Memanggil fungsi cek login status saat widget pertama kali di-load
  }

  // Fungsi untuk memeriksa status login
  void _checkLoginStatus(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));  // Delay untuk splash screen

    try {
      // Cek apakah pengguna sudah login menggunakan Firebase Authentication
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Jika sudah login, navigasikan ke HomeScreen dengan uid pengguna
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(uid: user.uid)),
        );
      } else {
        // Jika belum login, navigasikan ke LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print("Error in SplashScreen: $e");
      // Jika ada error, langsung arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Aplikasi Bimbingan Belajar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
