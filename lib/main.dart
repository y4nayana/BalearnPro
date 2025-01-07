import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';    // SplashScreen harus ada
import 'screens/home/home_screen.dart';  // Impor HomeScreen
import 'screens/auth/login_screen.dart'; // Impor LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Inisialisasi Firebase
  runApp(MyApp());  // Jalankan aplikasi setelah Firebase diinisialisasi
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Balearnpro',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),  // SplashScreen yang pertama
          '/home': (context) => HomeScreen(),  // Halaman Home
          '/login': (context) => LoginScreen(), // Halaman Login
        },
      ),
    );
  }
}
