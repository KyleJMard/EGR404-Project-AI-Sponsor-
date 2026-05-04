import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBu_sxdlKz3fD8OjUrGe5pvZgCKYPgp0DM",
            authDomain: "sipsmarter-7bafb.firebaseapp.com",
            projectId: "sipsmarter-7bafb",
            storageBucket: "sipsmarter-7bafb.firebasestorage.app",
            messagingSenderId: "345069558975",
            appId: "1:345069558975:web:d691b01c5d7fc6873d7a0a",
            measurementId: "G-YHNQB3VKKH"));
  } else {
    await Firebase.initializeApp();
  }
}
