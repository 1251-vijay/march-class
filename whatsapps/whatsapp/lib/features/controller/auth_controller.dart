// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';
import 'package:whatsapp/modes/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepositroy = ref.watch(authRepositroyProvider);
  return AuthController(authRepositroy: authRepositroy, ref: ref);
});

final getuserprovider = FutureProvider((ref) {
  final authRepositroy = ref.watch(authControllerProvider);
  return authRepositroy.getUserData();
});

class AuthController {
  final ProviderRef ref;
  final AuthRepositroy authRepositroy;

  AuthController({
    required this.ref,
    required this.authRepositroy,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepositroy.getUserData();
    return user;
  }

  void signInwithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepositroy.signInwithphonnumber(context, phoneNumber);
  }

  void verifyOtp(BuildContext context, String userOtp, String verificationId) {
    authRepositroy.verifyOtp(context, verificationId, userOtp);
  }

  void saveUserDataToFireStore(
      BuildContext context, String name, File profilePic) {
    authRepositroy.saveUserDataTOFirebase(
        context: context, ref: ref, name: name, profilePic: profilePic);
  }

  Stream<UserModel> userData(String userId) {
    return authRepositroy.userData(userId);
  }
}
