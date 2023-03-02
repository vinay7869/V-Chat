import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whp/Common/colors.dart';

import 'auth_controller.dart';
import '../Common/common_functions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/loginScreen';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _controller = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void pickaCountry() {
    showCountryPicker(
        context: context,
        // ignore: no_leading_underscores_for_local_identifiers
        onSelect: ((Country _country) {
          setState(() {
            country = _country;
          });
        }));
  }

  void nextFuntion() {
    String phoneNumber = _controller.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhonenumber(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: "Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Enter your phone number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("V-Chat will need to verify your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    pickaCountry();
                  },
                  child: const Text("Pick a country",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700))),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: _controller,
                      decoration:
                          const InputDecoration(hintText: "Phone number"),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height / 2),
              ElevatedButton(
                onPressed: nextFuntion,
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(90, 50)),
                child: const Text("Next",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
