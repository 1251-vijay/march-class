import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/features/landing/landing_screen.dart';
import 'package:whatsapp/routes.dart';
import 'package:whatsapp/screens/mobile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCPLA02hSyc-xptlQduTX_SvYj_-rvX6zc",
          appId: "1:332357586623:android:64c97f48fccbb5ea28400a",
          messagingSenderId: "332357586623",
          projectId: "whats-backend-d6250"));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(backgroundColor: appBarColor),
        ),
        onGenerateRoute: (settings) => generateRoutes(settings),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData) {
                return const MobileScreen();
              }
              return const LandingScreen();
            }));
  }
}
