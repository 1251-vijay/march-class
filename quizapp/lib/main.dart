import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/admin/admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAWd3rP7wdnf1AM3TDv4aHD6J5Lsa932Nc",
          appId: "1:999959023283:android:9781381f9db2e51744eac6",
          messagingSenderId: "999959023283",
          projectId: "quiz-c6452"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const AdminPannel());
  }
}
