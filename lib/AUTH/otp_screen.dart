import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/AUTH/auth_controller.dart';
import '../Common/colors.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String verificationId;
  const OtpScreen({required this.verificationId, super.key});

  static const routeName = '/otpScreen';

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  void verifyOTP(BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, widget.verificationId, userOTP);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your OTP"),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Text("We have sent an SMS with code",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "__  __  __  __  __  __",
                    hintStyle: TextStyle(fontWeight: FontWeight.w700)),
                obscureText: false,
                maxLength: 6,
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOTP(context, value.trim());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
