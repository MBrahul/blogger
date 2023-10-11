import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_3/screens/home/home.dart';
import 'package:flutter_application_3/screens/login/login.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogin = false;
  String email = "";
  void checkLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        isLogin = true;
        email = user.email.toString();
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    checkLogin();
    Timer(const Duration(milliseconds: 1400), () {
      if (isLogin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home(email);
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Login();
        }));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 249, 238, 252),
        child: Center(
            child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'Blogger',
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 91, 4, 115),
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'mainfont'),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          isRepeatingAnimation: false,
        )),
      ),
    );
  }
}
