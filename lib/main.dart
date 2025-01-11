import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Pastikan file ini dihasilkan oleh flutterfire configure
import 'screens/splash_screen.dart'; // Pastikan path sesuai dengan struktur proyek kamu
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Tambahkan ini untuk mendukung SQLite di Desktop
import 'package:flutter/foundation.dart'; // Untuk mendeteksi platform

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool firebaseInitialized = false;

  // Inisialisasi Firebase
  try {
    assert(() {
      print("Inisialisasi Firebase...");
      return true;
    }());
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    assert(() {
      print("Firebase Initialized Successfully");
      return true;
    }());
    firebaseInitialized = true;
  } catch (e) {
    assert(() {
      print("Error Initializing Firebase: $e");
      return true;
    }());
    firebaseInitialized = false;
  }

  // Inisialisasi SQLite untuk Desktop (Windows, MacOS, Linux)
  if (!kIsWeb && isDesktopPlatform()) {
    print("Inisialisasi SQLite untuk Desktop...");
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    print("SQLite Initialized for Desktop");
  }

  print("Menjalankan aplikasi...");
  runApp(MyApp(firebaseInitialized: firebaseInitialized));
}

// Deteksi apakah platform adalah Desktop
bool isDesktopPlatform() {
  return [
    TargetPlatform.windows,
    TargetPlatform.macOS,
    TargetPlatform.linux,
  ].contains(defaultTargetPlatform);
}

class MyApp extends StatelessWidget {
  final bool firebaseInitialized;

  MyApp({required this.firebaseInitialized});

  @override
  Widget build(BuildContext context) {
    print("Membangun widget utama...");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firebaseInitialized
          ? SplashScreen() // SplashScreen jika Firebase berhasil diinisialisasi
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