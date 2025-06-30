import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/auth_repository.dart';
import '../data/model/login_request.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({required this.repository}) : super(AuthInitial());

  Future<void> login(LoginRequest request) async {
    emit(AuthLoading());
    try {
      final response = await repository.login(request);
      emit(AuthSuccess(response: response));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
