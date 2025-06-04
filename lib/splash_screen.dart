import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pp1/social%20login_screen.dart';
import 'login_screen.dart'; // استيراد شاشة تسجيل الدخول

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SocialLoginScreen()), // الانتقال إلى شاشة تسجيل الدخول
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2.jpg',
              width: 500,
              height: 400,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
