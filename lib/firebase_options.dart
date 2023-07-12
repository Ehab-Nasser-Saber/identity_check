// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDZxc73hiIKn6nmycpXazr8Abs2yU7o_gk',
    appId: '1:854323172956:web:291617d8ff5e4ca2c6b899',
    messagingSenderId: '854323172956',
    projectId: 'identity-check-392512',
    authDomain: 'identity-check-392512.firebaseapp.com',
    storageBucket: 'identity-check-392512.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdKNkTN38-YJh26zgT9jI3BZcO6WdnKUw',
    appId: '1:854323172956:android:595ad4b1e1c23f0cc6b899',
    messagingSenderId: '854323172956',
    projectId: 'identity-check-392512',
    storageBucket: 'identity-check-392512.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBj2tghrv9wNIAXyNniPm0dvmoEmRO2TPM',
    appId: '1:854323172956:ios:8d088bdff5ee7bfec6b899',
    messagingSenderId: '854323172956',
    projectId: 'identity-check-392512',
    storageBucket: 'identity-check-392512.appspot.com',
    androidClientId: '854323172956-9ht2r086tdbr0cd5k547fr4q19qq84de.apps.googleusercontent.com',
    iosClientId: '854323172956-lbov1m40407hafn611nma5cvbp2mifkk.apps.googleusercontent.com',
    iosBundleId: 'com.example.identityCheck',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBj2tghrv9wNIAXyNniPm0dvmoEmRO2TPM',
    appId: '1:854323172956:ios:bbef9787c92bc978c6b899',
    messagingSenderId: '854323172956',
    projectId: 'identity-check-392512',
    storageBucket: 'identity-check-392512.appspot.com',
    androidClientId: '854323172956-9ht2r086tdbr0cd5k547fr4q19qq84de.apps.googleusercontent.com',
    iosClientId: '854323172956-0g6deut7i9ai9u2j9begalelgq41ooa8.apps.googleusercontent.com',
    iosBundleId: 'com.example.identityCheck.RunnerTests',
  );
}
