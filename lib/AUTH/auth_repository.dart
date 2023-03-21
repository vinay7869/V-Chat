import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/AUTH/image_provider.dart';
import 'package:whp/Common/common_functions.dart';
import 'package:whp/AUTH/otp_screen.dart';
import 'package:whp/Models/user_models.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebasefirestore: FirebaseFirestore.instance));

class AuthRepository {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebasefirestore;

  AuthRepository({required this.firebaseAuth, required this.firebasefirestore});

  Future<UserModels?> checkUserDetails() async {
    var userData = await firebasefirestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    UserModels? user;
    if (userData.data() != null) {
      user = UserModels.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhonenumber(BuildContext context, String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          await Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);

      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void saveUserDataToFirebase(BuildContext context, String name,
      File? profilePic, ProviderRef ref) async {
    String uid = firebaseAuth.currentUser!.uid;
    String photoURL = "assets/profilee.png";
    try {
      if (profilePic != null) {
        photoURL = await ref
            .read(imageProvider)
            .downloadImage("Profile Pics/$uid", profilePic);
      }

      var userData = UserModels(
          name: name,
          phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
          profilePic: photoURL,
          uid: uid);

      await firebasefirestore
          .collection('users')
          .doc(uid)
          .set(userData.toMap());

      // ignore: use_build_context_synchronously
     
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
