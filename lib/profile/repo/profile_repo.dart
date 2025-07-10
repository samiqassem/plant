import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/profile_response.dart';

class ProfileRepository {
  final Dio dio;

  ProfileRepository({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<ProfileResponse> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      throw Exception('⛔ Token not found in SharedPreferences');
    }

    try {
      final response = await dio.get(
        'https://44b24513-7b35-4cdf-ad0b-4d43fb90ec33-00-1h47iv5jolz8d.spock.replit.dev/api/auth/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('✅ Profile API Response: ${response.data}');

      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('⛔ DioException: ${e.response?.data}');
      throw Exception('Failed to load profile: ${e.response?.data['message'] ?? 'Unknown error'}');
    } catch (e) {
      print('⛔ Unexpected Error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
