import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/welcome.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // _navigateToWelcome();
  }

  // _navigateToWelcome() async {
  //   await Future.delayed(const Duration(milliseconds: 1500), () {});
  //    Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) =>  const Welcome()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF064650),
      body: Center(
        child: SizedBox(
          child: AnimatedSplashScreen(
            splash: 'images/3glogo-splash.png',
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color(0xFF064650),
            nextScreen: const Welcome(),
          ),
        ),
      ),
    );
  }
}
