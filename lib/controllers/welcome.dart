import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:troisgimmoapp/controllers/login_page.dart';
import 'package:troisgimmoapp/controllers/main_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
