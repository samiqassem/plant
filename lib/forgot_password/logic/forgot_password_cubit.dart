import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';
import '../../auth/data/auth_repository.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository repository;

  ForgotPasswordCubit({required this.repository}) : super(ForgotPasswordInitial());

  Future<void> sendResetLink(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final message = await repository.forgotPassword(email); // ✅ الدالة دلوقتي بترجع message
      emit(ForgotPasswordSuccess(message: message));
    } catch (e) {
      emit(ForgotPasswordFailure(error: e.toString()));
    }
  }
}