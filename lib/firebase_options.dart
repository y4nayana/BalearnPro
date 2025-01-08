// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCgn2QRhaMJvDI1-Ho2geoI6QWVbAXNnXI',
    appId: '1:366282983457:web:e482fddfc9ebfa578ffb60',
    messagingSenderId: '366282983457',
    projectId: 'balearnpro-842e5',
    authDomain: 'balearnpro-842e5.firebaseapp.com',
    storageBucket: 'balearnpro-842e5.firebasestorage.app',
    measurementId: 'G-4QTB4C9Q7J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChNFcRgRKiYT-yTRmc0J3VB7Kc15ck4l8',
    appId: '1:366282983457:android:e31f1a8219e275f58ffb60',
    messagingSenderId: '366282983457',
    projectId: 'balearnpro-842e5',
    storageBucket: 'balearnpro-842e5.firebasestorage.app',
  );
}
