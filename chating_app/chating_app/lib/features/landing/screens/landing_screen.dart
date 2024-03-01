import 'package:chating_app/features/auth/screens/login_screen.dart';
import 'package:chating_app/wigets/custom_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image1.png",
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Let's get Started",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Never better Time then now to start",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: CustomButton(
                text: "Get started",
                onpressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (_) => const LoginScreen()),
                  //     (route) => false);

                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
