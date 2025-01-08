import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Pastikan file ini dihasilkan oleh flutterfire configure
import 'screens/splash_screen.dart'; // Pastikan path sesuai dengan struktur proyek kamu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Gunakan konfigurasi dari firebase_options.dart
    );
    print("Firebase Initialized Successfully");
  } catch (e) {
    // Menangani error jika Firebase gagal diinisialisasi
    print("Error Initializing Firebase: $e");
    // Fallback jika Firebase gagal diinisialisasi, bisa menggunakan SplashScreen error
    runApp(MyApp(firebaseInitialized: false)); // Menandakan bahwa Firebase gagal diinisialisasi
    return; // Keluar dari fungsi main
  }

  // Jika berhasil, jalankan aplikasi dengan MyApp
  runApp(MyApp(firebaseInitialized: true));
}

class MyApp extends StatelessWidget {
  final bool firebaseInitialized;

  MyApp({required this.firebaseInitialized});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firebaseInitialized 
        ? SplashScreen()  // SplashScreen jika Firebase berhasil diinisialisasi
        : Scaffold(
            body: Center(
              child: Text(
                'Firebase Initialization Failed! Please check your configuration.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ),
    );
  }
}
