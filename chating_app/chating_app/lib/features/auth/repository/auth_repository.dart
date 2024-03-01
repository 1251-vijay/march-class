// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chating_app/common/utlis/utlis.dart';
import 'package:chating_app/features/auth/screens/otp_screen.dart';
import 'package:chating_app/features/auth/screens/user_informaton.dart';
import 'package:chating_app/models/user_model.dart';
import 'package:chating_app/screens/mobile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signWithPhone(BuildContext context, String phonenumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {},
          codeSent: (String verificationId, int? resendingToken) {
            Navigator.pushNamed(context, OtpScreen.routeName,
                arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (e) {});
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.message!);
    }
  }

  void verifyOtp(
      BuildContext context, String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, UserInformationScreen.routeName, (route) => false);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void saveUserDataFirestore(
    BuildContext context,
    File? profilepic,
    ProviderRef ref,
    String name,
  ) async {
    try {
      String uid = auth.currentUser!.uid;
      String photourl =
          "https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png";
      if (profilepic != null) {
        photourl = await ref
            .read(commonFilebaseRepository)
            .saveImagefirestore("profilePic/$uid", profilepic);
      }
      var userModel = UserModel(
          name: name,
          uid: uid,
          profilePic: photourl,
          phoneNumber: auth.currentUser!.phoneNumber.toString(),
          isOnline: true,
          groupId: []);
      await firestore.collection("users").doc(uid).set(userModel.toMap());
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const MobileScreen()),
          (route) => false);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  Future<UserModel?> getUserDetails() async {
    var user =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    UserModel? userModel;
    if (user.data() != null) {
      userModel = UserModel.fromMap(user.data()!);
    } else {}

    return userModel;
  }

  Stream<UserModel> userDataId(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void userIsOnlineOrOffline(bool isOnline) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"isOnline": isOnline});
  }
}
