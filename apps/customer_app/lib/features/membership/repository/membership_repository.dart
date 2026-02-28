import 'package:dio/dio.dart';
import 'package:models/models.dart';

class MembershipRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));

  Future<Membership?> getMyMembership() async {
    try {
      final response = await _dio.get('/memberships/me');
      if (response.data == null) return null;
      return Membership.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<Membership> subscribe(String plan) async {
    final response = await _dio.post('/memberships/subscribe', data: {'plan': plan});
    return Membership.fromJson(response.data);
  }
}
