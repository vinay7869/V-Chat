import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whp/AUTH/auth_controller.dart';
import 'package:whp/Common/loader.dart';
import 'package:whp/Common/router.dart';
import 'package:whp/screens/home_screen.dart';
import 'package:whp/screens/landing_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: "WhatsApp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff075E54),
        ),
        onGenerateRoute: (settings) => getRoute(settings),
        home: AnimatedSplashScreen(
            splash: const Image(image: AssetImage('assets/splash.webp')),
            splashIconSize: 350,
            splashTransition: SplashTransition.fadeTransition,
            duration: 1,
            // nextScreen: const LandingScreen(),
            nextScreen: ref.watch(futureControllerProvider).when(
                  data: (user) {
                    if (user == null) {
                      return const LandingScreen();
                    }
                    return const MyHomePage();
                  },
                  error: (error, stackTrace) => const Loader(),
                  loading: () => const Loader(),
                )
                ));
  }
}
