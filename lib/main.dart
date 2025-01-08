import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';  // Pastikan ini ada
import 'config/firebase_options.dart'; // Pastikan sudah mengimpor firebase_options.dart


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase dengan FirebaseOptions
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  // Menggunakan DefaultFirebaseOptions
  
  runApp(MyApp());
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
          '/': (context) => SplashScreen(),
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
