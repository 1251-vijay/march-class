import 'package:chating_app/features/auth/screens/login_screen.dart';
import 'package:chating_app/features/auth/screens/otp_screen.dart';
import 'package:chating_app/features/auth/screens/user_informaton.dart';
import 'package:chating_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case OtpScreen.routeName:
      final verificationid = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => OtpScreen(verificationId: verificationid));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const UserInformationScreen());
    case ChatScreen.routeName:
      final argument = settings.arguments as Map<String, dynamic>;
      final name = argument["name"];
      final uid = argument["uid"];
      return MaterialPageRoute(
          builder: (_) => ChatScreen(
                message: name,
                uid: uid,
              ));
  }
  return MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Center(
              child: Text("No Data Found"),
            ),
          ));
}
