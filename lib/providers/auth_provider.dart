import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get currentUser => _user;

  // Fungsi untuk memuat status login pengguna saat aplikasi pertama kali dijalankan
  Future<void> initialize() async {
    try {
      _user = _auth.currentUser;  // Mengambil status pengguna saat ini
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to initialize user: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;

      // Update the user's display name
      await _user?.updateDisplayName(name);
      await _user?.reload();
      _user = _auth.currentUser;
      notifyListeners();
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  bool get isLoggedIn => _user != null;
}
