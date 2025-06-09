import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login/data/repos/auth_repository.dart';
import 'login/logic/auth_cubit.dart';
import 'login/ui/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthCubit(repository: repository),
        child: const LoginScreen(),
      ),
    );
  }
}
