import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCjwRB5XgWayn7wuIoCZuFcayABBwJ1zCw",
            authDomain: "dazel-dating-app.firebaseapp.com",
            projectId: "dazel-dating-app",
            storageBucket: "dazel-dating-app.appspot.com",
            messagingSenderId: "465867908563",
            appId: "1:465867908563:web:3d3f9eea626bf03ab3fb26",
            measurementId: "G-PJ0XZMN8TG"));
  } else {
    await Firebase.initializeApp();
  }
}
