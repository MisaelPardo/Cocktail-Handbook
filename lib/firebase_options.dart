import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
    apiKey: 'AIzaSyCWxAKyZhXhxkKhWkX8qg5swvA3BPrYe6o',
    appId: '1:436403733833:web:1f04af17fc1fc73ff00698',
    messagingSenderId: '436403733833',
    projectId: 'cocktail-handbook-66398',
    authDomain: 'cocktail-handbook-66398.firebaseapp.com',
    storageBucket: 'cocktail-handbook-66398.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfnZ9oks7vUyebNZoPf0N_L22Py-KnR3s',
    appId: '1:436403733833:android:f1c13d06802c87a4f00698',
    messagingSenderId: '436403733833',
    projectId: 'cocktail-handbook-66398',
    storageBucket: 'cocktail-handbook-66398.firebasestorage.app',
  );
}
