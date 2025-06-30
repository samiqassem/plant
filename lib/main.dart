import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/data/auth_repository.dart';
import 'home_page.dart';
import 'login/logic/auth_cubit.dart';

import 'sign_up/logic/signup_cubit.dart';
import 'sign_up/ui/sign up_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    isLoggedInFuture = checkIfLoggedIn();
  }

  Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final repository = AuthRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(repository: repository)),
        BlocProvider(create: (_) => SignUpCubit(repository: repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: isLoggedInFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.data == true) {
              return const HomePage(); // لو فيه توكن
            } else {
              return const SignUpScreen(); // لو مفيش توكن
            }
          },
        ),
      ),
    );
  }
}
