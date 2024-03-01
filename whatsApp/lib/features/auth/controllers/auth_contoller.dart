import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';

final authController = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref);
});

final getUserDataData = FutureProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getDataInformation();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController(this.ref, {required this.authRepository});

  void signWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signWithPhone(context, phoneNumber);
  }

  void verifyOtp(BuildContext context, String userOtp, String verificationId) {
    authRepository.verifyOtp(context, verificationId, userOtp);
  }

  void saveDataToFireStore(
    BuildContext context,
    String name,
    File profilePic,
  ) {
    authRepository.saveDataToFirestore(name, profilePic, context, ref);
  }

  void setuserState(bool isOnline) {
    authRepository.setUserSate(isOnline);
  }
}
