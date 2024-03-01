import 'package:flutter/material.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp/features/chat/screens/chat_screen.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => OtpScreen(
                verificationId: verificationId,
              ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const UserInformationScreen());
    case ChatScreen.routeName:
      final argument = settings.arguments as Map<String, dynamic>;
      final name = argument["name"];
      final uid = argument["uid"];
      final profilePic = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => ChatScreen(
                name: name,
                uid: uid,
                profilePic: profilePic,
              ));
  }
  return MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Center(
              child: Text("No data Found"),
            ),
          ));
}
