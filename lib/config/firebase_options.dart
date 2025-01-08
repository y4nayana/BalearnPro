import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('Unsupported platform');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCNBtIfB0ycOyIPvSMBSq4aUNTEkdEb5qs',
    appId: '1:283866349676:web:99d4ab07812127bbce1849',  // Ambil dari json
    messagingSenderId: '283866349676',  // Ambil dari json
    projectId: 'balearnpro',  // Ambil dari json
    authDomain: 'balearnpro.firebaseapp.com',  // Sesuaikan jika perlu
    storageBucket: 'balearnpro.appspot.com',  // Sesuaikan jika perlu
    measurementId: 'G-1234567890',  // Jika ada di json
  );
}
