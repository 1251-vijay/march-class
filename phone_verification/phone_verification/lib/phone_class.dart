import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/otp_screen.dart';

class PhoneAuth {
  phoneverification(BuildContext context, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await FirebaseAuth.instance
                .signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (e) {},
          codeSent: (String verification, int? token) {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => const Otp()));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      print(e.toString());
    }
  }
}
