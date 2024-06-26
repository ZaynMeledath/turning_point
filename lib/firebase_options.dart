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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSHP3FHVKXYgLNB4WkY3Vr3PFdmy6-deA',
    appId: '1:307677340790:android:ce191e23ebe91565caab57',
    messagingSenderId: '307677340790',
    projectId: 'turning-point-vapi',
    storageBucket: 'turning-point-vapi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_mx6YLhBCVyk1luPlHDC-z1BKwxkPf3o',
    appId: '1:307677340790:ios:fc2030cf59e82003caab57',
    messagingSenderId: '307677340790',
    projectId: 'turning-point-vapi',
    storageBucket: 'turning-point-vapi.appspot.com',
    androidClientId: '307677340790-qsj59j2khamaodtvg7g5ajv1hsgossu2.apps.googleusercontent.com',
    iosClientId: '307677340790-fo6gtkidmoo4d06raeaojhp7v229bugi.apps.googleusercontent.com',
    iosBundleId: 'com.example.turningPoint',
  );
}
