import 'package:flutter/material.dart';
import 'package:whp/AUTH/login_screen.dart';
import '../Common/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void toLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Welcome to V-Chat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: size.height / 11),
              const Image(
                  image: AssetImage("assets/wp.png"), height: 250, width: 250),
              SizedBox(height: size.height / 4),
              const Text(
                'Read our privacy policy.  Tap "Agree and Continue" to accept the terms and services.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.70,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 10,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      toLoginScreen(context);
                    } ,
                    child: const Text(
                      "Agree and Continue",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
