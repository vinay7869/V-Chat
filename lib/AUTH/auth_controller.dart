import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/AUTH/auth_repository.dart';
import 'package:whp/Models/user_models.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

final futureControllerProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.checkUserDetails();
  },
);

class AuthController {
  AuthRepository authRepository;
  ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModels?> checkUserDetails() async {
    UserModels? user = await authRepository.checkUserDetails();
    return user;
  }

  void signInWithPhonenumber(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhonenumber(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationId, userOTP: userOTP);
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(context, name, profilePic, ref);
  }
}
