import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/features/auth/controllers/auth_contoller.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = "otp-screen";
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  void verifyOtp(WidgetRef ref, BuildContext context, String userOtp) {
    ref.read(authController).verifyOtp(context, userOtp, verificationId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Verifying your number'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOtp(ref, context, val.trim());
                  }
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "- - - - - - ",
                    hintStyle: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
