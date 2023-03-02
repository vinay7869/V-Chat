import 'package:flutter/material.dart';
import 'package:whp/AUTH/login_screen.dart';
import 'package:whp/AUTH/otp_screen.dart';
import 'package:whp/AUTH/user_information_screen.dart';
import 'package:whp/Chat_Widgets/chat_appbar.dart';
import 'package:whp/Contacts/contact_screen.dart';
import 'package:whp/screens/home_screen.dart';

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OtpScreen.routeName:
      final verificationId = settings.arguments.toString();
      return MaterialPageRoute(
        builder: (context) => OtpScreen(verificationId: verificationId),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );
    case MyHomePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      );
    case ChatAppbar.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) =>
            ChatAppbar(name: name, profilePic: profilePic, uid: uid),
      );
    case ContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Error')),
        ),
      );
  }
}
