import 'package:menumo/pages/home_page.dart';
import 'package:menumo/services/auth/login_or_register.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            // user is NOT logged in
            return const LoginOrRegister();
          }
        },
      ), // StreamBuilder
    ); // Scaffold
  }
}
