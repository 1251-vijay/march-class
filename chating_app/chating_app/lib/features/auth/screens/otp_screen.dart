import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = "Otp-screen";
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  void verifyOtp(WidgetRef ref, BuildContext context, String userOtp) {
    ref
        .read(authControllerProvider)
        .verifyOtp(context, userOtp, verificationId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 80, 30, 196)),
              child: Image.asset(
                "assets/image3.png",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("We have sent an SMS with a code"),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  onChanged: (val) {
                    if (val.length == 6) {
                      verifyOtp(ref, context, val.trim());
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "- - - - - - ",
                    hintStyle: TextStyle(fontSize: 20),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
