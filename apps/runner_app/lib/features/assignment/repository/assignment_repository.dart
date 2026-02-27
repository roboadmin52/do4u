import 'package:dio/dio.dart';
import 'package:models/models.dart';

class AssignmentRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.do4u.app/v1'));

  Future<RunnerProfile> toggleAvailability(bool isAvailable) async {
    final response = await _dio.patch('/runner/availability', data: {'is_available': isAvailable});
    return RunnerProfile.fromJson(response.data);
  }

  Future<List<Errand>> getAssignments() async {
    final response = await _dio.get('/runner/assignments');
    return (response.data as List).map((e) => Errand.fromJson(e)).toList();
  }

  Future<Errand> updateStatus(String errandId, String status) async {
    final response = await _dio.patch('/runner/assignments/$errandId/status', data: {'status': status});
    return Errand.fromJson(response.data);
  }

  Future<void> updateLocation(double lat, double lng) async {
    await _dio.post('/runner/location', data: {'lat': lat, 'lng': lng});
  }
}
