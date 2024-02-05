import 'package:chatter/view/authentication_screen/login_or_signup_screen.dart';
import 'package:chatter/view/home_screen/home_screen.dart';
import 'package:chatter/widgets/global/firebase_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool isActive = authInstance.currentUser != null;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: isActive ? MyHomeScreen() : LoginOrSignUpScreen(),
    );
  }
}
