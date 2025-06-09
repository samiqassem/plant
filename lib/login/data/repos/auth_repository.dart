import 'package:dio/dio.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        'https://44b24513-7b35-4cdf-ad0b-4d43fb90ec33-00-1h47iv5jolz8d.spock.replit.dev/api/auth/login', // غيّر الرابط ده حسب سيرفرك
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          'Login failed: ${e.response?.data['message'] ?? 'Unknown error'}');
    }
  }
}
