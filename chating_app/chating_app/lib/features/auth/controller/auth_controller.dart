// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chating_app/features/auth/repository/auth_repository.dart';
import 'package:chating_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref);
});

final getUserDataFirestore = FutureProvider((ref) {
  final authc = ref.watch(authControllerProvider);
  return authc.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController(
    this.ref, {
    required this.authRepository,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getUserDetails();
    return user;
  }

  void signWithPhone(BuildContext context, String phonenumber) {
    authRepository.signWithPhone(context, phonenumber);
  }

  void verifyOtp(BuildContext context, String userOtp, String verificationId) {
    authRepository.verifyOtp(context, verificationId, userOtp);
  }

  void saveUserDataFireStore(
    BuildContext context,
    String name,
    File? file,
  ) {
    authRepository.saveUserDataFirestore(context, file, ref, name);
  }

  Stream<UserModel> userDataId(String userId) {
    return authRepository.userDataId(userId);
  }

  void userIsonlineOrOffline(bool isOnline) {
    authRepository.userIsOnlineOrOffline(isOnline);
  }
}
