import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/Common/common_functions.dart';
import '../screens/home_screen.dart';
import 'auth_controller.dart';
import '../Common/colors.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});
  static const routeName = "/userinfoscreen";

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final _controller = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void saveUserDataToFirebase() {
    String name = _controller.text.trim();
    ref
        .read(authControllerProvider)
        .saveUserDataToFirebase(context, name, image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage("assets/profilee.png"),
                          backgroundColor: Colors.white,
                          radius: 70,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 70,
                        ),
                  Positioned(
                      bottom: 2,
                      left: 90,
                      child: IconButton(
                          icon: const Icon(Icons.add_a_photo_rounded),
                          color: primaryColor,
                          iconSize: 37,
                          onPressed: () async {
                            image = await pickImageFromGallery(context);
                            setState(() {});
                          }))
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        saveUserDataToFirebase();
                        Navigator.pushNamedAndRemoveUntil(
                            context, MyHomePage.routeName, (route) => false);
                      },
                      icon: const Icon(Icons.done_rounded))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
