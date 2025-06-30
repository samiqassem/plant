import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/data/model/login_request.dart';
import '../../login/data/model/login_response.dart';
import '../../sign_up/data/model/sign_up_request.dart';
import '../../sign_up/data/model/sign_up_response.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({Dio? dioClient}) : dio = dioClient ?? Dio();

  // 🟢 تسجيل الدخول
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        'https://44b24513-7b35-4cdf-ad0b-4d43fb90ec33-00-1h47iv5jolz8d.spock.replit.dev/api/auth/login',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      // 🧠 حفظ التوكن بعد نجاح تسجيل الدخول
      await _saveToken(loginResponse.token);

      return loginResponse;
    } on DioException catch (e) {
      throw Exception(
        'Login failed: ${e.response?.data['message'] ?? 'Unknown error'}',
      );
    }
  }

  // 🟡 إنشاء حساب جديد (sign up)
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await dio.post(
        'https://44b24513-7b35-4cdf-ad0b-4d43fb90ec33-00-1h47iv5jolz8d.spock.replit.dev/api/auth/register',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ SignUp success: ${response.statusCode}');
      return SignUpResponse.fromStatusCode(response.statusCode ?? 201);
    } on DioException catch (e) {
      print('⛔ SignUp error: ${e.response?.statusCode}');
      print('⛔ Body: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ?? 'Sign up failed with unknown error',
      );
    }
  }

  // 🔒 حفظ التوكن في SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
