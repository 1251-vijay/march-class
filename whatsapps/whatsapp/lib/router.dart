import 'package:flutter/material.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_information.dart';
import 'package:whatsapp/screens/chats_screen.dart';

Route<dynamic> generateroutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routename:
      return MaterialPageRoute(
        builder: (builder) => const LoginScreen(),
      );
    case OtpScreen.routename:
      final verifactionId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (builder) => OtpScreen(
          verifactionId: verifactionId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (builder) => const UserInformationScreen(),
      );
    case ChatScreen.routename:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments["name"];
      final uid = arguments["uid"];
      return MaterialPageRoute(
          builder: (builder) => ChatScreen(
                name: name,
                uid: uid,
              ));
    default:
      return MaterialPageRoute(
          builder: (builder) => const Scaffold(
                body: Center(
                  child: Text("No Data found"),
                ),
              ));
  }
}
