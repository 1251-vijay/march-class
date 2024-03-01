import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/features/controller/auth_controller.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:whatsapp/router.dart';
import 'package:whatsapp/screens/mobile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAt6DgKkX_TAFaxQc2qW800DrwZ6jAu6AI",
        appId: "1:711269006183:android:f5603db2d2184f62b04dc2",
        messagingSenderId: "711269006183",
        projectId: "whatsap-backend-776ee"),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
          scaffoldBackgroundColor: backgroundColor,
        ),
        onGenerateRoute: ((settings) => generateroutes(settings)),
        // home: ref.watch(getuserprovider).when(data: (user) {
        //   if (user == null) {
        //     const LandingScreen();
        //   }
        //   return const MobileScreen();
        // }, error: (error, stacktree) {
        //   return;
        // }, loading: () {
        //   return const Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }
        // ),
        // );
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return const MobileScreen();
              }
              return const LandingScreen();
            }));
  }
}
