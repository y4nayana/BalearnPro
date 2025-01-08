import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAuth();  // Memanggil fungsi untuk menginisialisasi AuthProvider
  }

  Future<void> _initializeAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // Memanggil metode initialize() untuk memeriksa status login pengguna
    await authProvider.initialize();  

    // Tambahkan log untuk memeriksa status login
    print('Is user logged in: ${authProvider.isLoggedIn}');

    // Menunggu beberapa detik sebelum navigasi
    Future.delayed(Duration(seconds: 3), () {
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');  // Jika sudah login
      } else {
        Navigator.pushReplacementNamed(context, '/login');  // Jika belum login
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Balearnpro',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
