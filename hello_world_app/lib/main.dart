import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_app/home/home.dart';

void main() async {
  String n = " vijay";
  print(n.substring(0, 4));
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyCXvPCVqET-tGCD60srrgJldudKAwEtsYM",
  //         appId: "1:794140815:android:8bd840d3f8e876f0cc90fa",
  //         messagingSenderId: "794140815",
  //         projectId: "todoapp-99a1a"));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
