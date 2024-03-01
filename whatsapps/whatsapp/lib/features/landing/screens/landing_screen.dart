import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/common/utils/widgets/custom_button.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Welcome to WhatsApp",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height / 9,
          ),
          Image.asset(
            "assets/images/bg.png",
            height: 340,
            width: 410,
            color: tabColor,
          ),
          SizedBox(
            height: size.height / 9,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "Read our Privacy Policy. Tap 'Agree and continue' to accept the Terms of Service.",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                  text: 'Agree and Continue',
                  onpressed: () {
                    Navigator.pushNamed(context, LoginScreen.routename);
                  })),
        ],
      )),
    );
  }
}
