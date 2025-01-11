import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Pastikan sudah sesuai
import 'Login/login_screen.dart'; // Pastikan sudah sesuai

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(context); // Memeriksa status login saat splash screen ditampilkan
  }

  // Fungsi untuk memeriksa status login
  void _checkLoginStatus(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3)); // Delay untuk splash screen

    try {
      // Periksa apakah pengguna sudah login menggunakan Firebase Authentication
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Jika sudah login, navigasi ke HomeScreen dengan uid pengguna
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(uid: user.uid)),
        );
      } else {
        // Jika belum login, navigasi ke LoginScreen
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
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Path ke background image
              fit: BoxFit.cover, // Memastikan gambar memenuhi seluruh layar
            ),
          ),
          // Konten Splash Screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo di tengah
                Image.asset(
                  'assets/splash.png', // Path ke logo
                  width: 150, // Sesuaikan ukuran logo
                  height: 150,
                ),
                SizedBox(height: 20), // Jarak antara logo dan teks
                // Teks di bawah logo
                Text(
                  'BalearnPro',
                  style: TextStyle(
                    fontSize: 28, // Ukuran font
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks
                  ),
                ),
                SizedBox(height: 40), // Jarak antara teks dan loading indicator
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
