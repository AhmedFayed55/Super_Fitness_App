// File generated manually with web support
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC0BH0mqHYQhnB1tt5m-YgU4PmLAYn-voY',
    appId: '1:198045329093:web:aa921865b6a300f35b32ac',
    messagingSenderId: '198045329093',
    projectId: 'super-fitness-app-9edda',
    authDomain: 'super-fitness-app-9edda.firebaseapp.com',
    storageBucket: 'super-fitness-app-9edda.firebasestorage.app',
    measurementId: 'G-RC0EGP5BQW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAexi4szlkk9kheUPi_SoTqol3uhyEhcyA',
    appId: '1:198045329093:android:db9f6297404587455b32ac',
    messagingSenderId: '198045329093',
    projectId: 'super-fitness-app-9edda',
    storageBucket: 'super-fitness-app-9edda.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_fNrjV08jbg6Vkmo4bLqKDEU-NBhJiUs',
    appId: '1:198045329093:ios:4f1c3dd4dcd28dea5b32ac',
    messagingSenderId: '198045329093',
    projectId: 'super-fitness-app-9edda',
    storageBucket: 'super-fitness-app-9edda.firebasestorage.app',
    iosBundleId: 'com.example.superFitnessApp',
  );
}
