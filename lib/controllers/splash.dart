import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'welcome.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    getPicturesFromStorage();
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

  Future<List> getPicturesFromStorage() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userID = user?.uid ?? "0";
    List urlList = [];
    final ListResult result =
        await FirebaseStorage.instance.ref('feed/$userID/images/').listAll();
    for (final ref in result.items) {
      final url = await ref.getDownloadURL();
      CachedNetworkImage(
        imageUrl: url,
      );
      urlList.add(url.toString());
    }

    return urlList;
  }
}
