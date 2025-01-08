import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balearnpro/providers/auth_provider.dart'; // Import AuthProvider jika diperlukan

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Langsung arahkan ke HomeScreen setelah 2 detik
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home'); // Langsung menuju HomeScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),  // Tampilkan loading screen sementara
    );
  }
}
