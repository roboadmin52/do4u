import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:models/models.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> sendOtp(String phone) async {
    await _dio.post('/auth/send-otp', data: {'phone': phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await _dio.post('/auth/verify-otp', data: {
      'phone': phone,
      'otp': otp,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> register({
    required String phone,
    required String fullName,
    String? email,
  }) async {
    final response = await _dio.post('/auth/register', data: {
      'phone': phone,
      'full_name': fullName,
      'email': email,
    });
    return response.data;
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}
