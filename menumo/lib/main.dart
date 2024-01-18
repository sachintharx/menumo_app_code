//import 'package:menumo/pages/LoginPage.dart';
//import 'package:menumo/pages/RegisterPage.dart';
//import 'package:menumo/pages/QR_code/qr_scan_page.dart';
//import 'package:menumo/pages/intro_page/intro_page.dart';
import 'package:menumo/services/auth/auth_gate.dart';
import 'package:menumo/services/auth/auth_service.dart';
//import 'package:menumo/services/auth/login_or_register.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Make sure you have the correct import for Firebase options.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(), //LoginPage(), // Assuming LoginPage is defined and correctly implemented.
          //IntroPage(),
          //QRCode(),
    );
  }
}
