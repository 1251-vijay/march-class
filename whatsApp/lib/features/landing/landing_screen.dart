import 'package:flutter/material.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/common/widgets/custom_button.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Welcome to WhatsApp",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height / 9),
          Image.asset(
            "assets/images/bg.png",
            height: 340,
            width: 340,
            color: tabColor,
          ),
          SizedBox(
            height: size.height / 9,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Read our Privacy Policy. Tap 'Agree and continue' to accept the Terms of Service.",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            width: size.width * 0.75,
            child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onpressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }),
          )
        ],
      )),
    );
  }
}
