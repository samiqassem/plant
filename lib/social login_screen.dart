import 'package:flutter/material.dart';
import 'login_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الصورة (إذا كانت موجودة)
              Container(
                width: 450,
                height: 300,
                child: Image.asset(
                  'assets/images/p1.png', // استبدل بالصورة الخاصة بك
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sign In with",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              // زر تسجيل الدخول عبر Google
              SizedBox(
                width: 250, // العرض الثابت
                height: 50, // الارتفاع الثابت
                child: ElevatedButton.icon(
                  onPressed: () {
                    // تسجيل الدخول عبر Google
                  },
                  icon: Image.asset(
                    'assets/images/Google.png', // أيقونة Google
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // زر تسجيل الدخول عبر Facebook
              SizedBox(
                width: 250, // العرض الثابت
                height: 50, // الارتفاع الثابت
                child: ElevatedButton.icon(
                  onPressed: () {
                    // تسجيل الدخول عبر Facebook
                  },
                  icon: Image.asset(
                    'assets/images/Facebook.png', // أيقونة Facebook
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    "Continue with Facebook",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // زر تسجيل الدخول عبر Apple
              SizedBox(
                width: 250, // العرض الثابت
                height: 50, // الارتفاع الثابت
                child: ElevatedButton.icon(
                  onPressed: () {
                    // تسجيل الدخول عبر Apple
                  },
                  icon: Image.asset(
                    'assets/images/apple white.png', // أيقونة Apple
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    "Continue with Apple",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // زر Use Email Instead
              SizedBox(
                width: 250, // العرض الثابت
                height: 50, // الارتفاع الثابت
                child: ElevatedButton(
                  onPressed: () {
                    // الانتقال إلى شاشة تسجيل الدخول بالبريد الإلكتروني
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.1), // لون خفيف
                    foregroundColor: Colors.green, // لون النص
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.green), // إطار أخضر
                    ),
                    elevation: 0, // إزالة الظل
                  ),
                  child: const Text(
                    "Use Email Instead",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}