import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/data/auth_repository.dart';
import '../data/model/sign_up_request.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository repository;

  SignUpCubit({required this.repository}) : super(SignUpInitial());

  Future<void> signUp(SignUpRequest request) async {
    emit(SignUpLoading());
    try {
      final response = await repository.signUp(request);

      // تحقق من وجود التوكن واحفظه
      if (response.token != null && response.token!.isNotEmpty) {
        await saveToken(response.token!);
        emit(SignUpSuccess("User registered successfully"));
      } else {
        emit(SignUpFailure("Registration succeeded but token is missing"));
      }
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
