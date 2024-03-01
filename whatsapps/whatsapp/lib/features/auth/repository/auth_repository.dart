// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/utlis.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_information.dart';
import 'package:whatsapp/modes/user_model.dart';
import 'package:whatsapp/screens/mobile_screen.dart';

final authRepositroyProvider = Provider(
  (ref) => AuthRepositroy(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepositroy {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<UserModel?> getUserData() async {
    UserModel? usermodel;
    var user =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    if (user.data() != null) {
      usermodel = UserModel.fromMap(user.data()!);
    }
    return usermodel;
  }

  AuthRepositroy({required this.auth, required this.firestore});
  void signInwithphonnumber(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showSnackBar(context: context, content: e.message!);
            throw Exception(e.toString());
          },
          codeSent: (String verificationId, int? forceesendingToken) async {
            Navigator.pushNamed(context, OtpScreen.routename,
                arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOtp(
      BuildContext context, String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      await auth.signInWithCredential(credential);

      Navigator.pushNamedAndRemoveUntil(
          context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataTOFirebase({
    required BuildContext context,
    required ProviderRef ref,
    required String name,
    required File? profilePic,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      // ignore: unused_local_variable
      String photoUrl =
          "https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png";
      // ignore: unnecessary_null_comparison
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFireBaseStorageRepository)
            .storeFileToFirebase(
                context: context,
                ref: "profilPic/$uid",
                profilePic: profilePic);
        var usermodel = UserModel(
            name: name,
            isOnline: true,
            profilePic: photoUrl,
            groupId: [],
            phoneNumber: auth.currentUser!.phoneNumber!,
            uid: uid);
        await firestore.collection("users").doc(uid).set(usermodel.toMap());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const MobileScreen()),
            (route) => false);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
