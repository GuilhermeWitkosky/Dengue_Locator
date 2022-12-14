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
    apiKey: "AIzaSyAPvyrcnms8AZa__ezFvZmuiFHl2MFmT0k",
    authDomain: "crud-flutter-1-f63e5.firebaseapp.com",
    projectId: "crud-flutter-1-f63e5",
    storageBucket: "crud-flutter-1-f63e5.appspot.com",
    messagingSenderId: "999969842669",
    appId: "1:999969842669:web:673dbbaf75fc899c2d33e4",
    measurementId: "G-75YEMBJL3M",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7ry5xa5PncLNqBp292emYplPAP1XySrQ',
    appId: '1:999969842669:android:3f718e1e0b0ad6862d33e4',
    messagingSenderId: '999969842669',
    projectId: 'crud-flutter-1-f63e5',
    storageBucket: 'crud-flutter-1-f63e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACuTw-ysCFD_9629HI4ZVt3v48FsyxNBY',
    appId: '1:886691144291:ios:219cd7e02e999de3bc8e56',
    messagingSenderId: '886691144291',
    projectId: 'dengue-locator-1',
    storageBucket: 'dengue-locator-1.appspot.com',
    iosClientId:
        '886691144291-9luo00u3hccmer6rlb229fct3ek0i1hk.apps.googleusercontent.com',
    iosBundleId: 'com.example.degueLocator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACuTw-ysCFD_9629HI4ZVt3v48FsyxNBY',
    appId: '1:886691144291:ios:219cd7e02e999de3bc8e56',
    messagingSenderId: '886691144291',
    projectId: 'dengue-locator-1',
    storageBucket: 'dengue-locator-1.appspot.com',
    iosClientId:
        '886691144291-9luo00u3hccmer6rlb229fct3ek0i1hk.apps.googleusercontent.com',
    iosBundleId: 'com.example.degueLocator',
  );
}
