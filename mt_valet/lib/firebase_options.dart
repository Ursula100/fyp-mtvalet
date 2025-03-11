// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

//show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['WEB_API_KEY'] ?? "",
    appId: '1:85437198716:web:5c2b83deda151675bc74f9',
    messagingSenderId: '85437198716',
    projectId: 'mt-valet-app',
    authDomain: 'mt-valet-app.firebaseapp.com',
    storageBucket: 'mt-valet-app.firebasestorage.app',
    measurementId: 'G-Z7885K54S5',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['ANDROID_API_KEY'] ?? "",
    appId: '1:85437198716:android:447f7f553b9c3a88bc74f9',
    messagingSenderId: '85437198716',
    projectId: 'mt-valet-app',
    storageBucket: 'mt-valet-app.firebasestorage.app',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['IOS_API_KEY'] ?? "",
    appId: '1:85437198716:ios:d0ea4b03e921cf5abc74f9',
    messagingSenderId: '85437198716',
    projectId: 'mt-valet-app',
    storageBucket: 'mt-valet-app.firebasestorage.app',
    iosBundleId: 'com.example.mtValet',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.env['MAC_API_KEY'] ?? "",
    appId: '1:85437198716:ios:d0ea4b03e921cf5abc74f9',
    messagingSenderId: '85437198716',
    projectId: 'mt-valet-app',
    storageBucket: 'mt-valet-app.firebasestorage.app',
    iosBundleId: 'com.example.mtValet',
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: dotenv.env['WIN_API_KEY'] ?? "",
    appId: '1:85437198716:web:9b1c39068cb680b4bc74f9',
    messagingSenderId: '85437198716',
    projectId: 'mt-valet-app',
    authDomain: 'mt-valet-app.firebaseapp.com',
    storageBucket: 'mt-valet-app.firebasestorage.app',
    measurementId: 'G-QHXQFJ4K8C',
  );

}