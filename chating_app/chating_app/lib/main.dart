import "package:chating_app/features/auth/controller/auth_controller.dart";
import "package:chating_app/features/landing/screens/landing_screen.dart";
import "package:chating_app/routes.dart";
import "package:chating_app/screens/mobile_screen.dart";
// import "package:chating_app/screens/mobile_screen.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAoIT4vupiyQScOpUNrucClFTwoh1dc0-A",
          appId: "1:597246731945:android:dd8c891783191b6faeebb8",
          messagingSenderId: "597246731945",
          projectId: "chatapp-backend-45b11"));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
        onGenerateRoute: (settings) => generatedRoutes(settings),
        home: ref.watch(getUserDataFirestore).when(
            data: (user) {
              // print(user);
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileScreen();
            },
            error: (e, strackTree) => Scaffold(
                  body: Text(e.toString()),
                ),
            loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ))
        // home: LandingScreen()

        );
  }
}
