import 'package:dio/dio.dart';
import 'package:models/models.dart';

class ErrandRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));

  Future<Map<String, dynamic>> getPriceEstimate({
    required ErrandCategory category,
    required String subType,
    required Map<String, dynamic> pickupAddress,
    Map<String, dynamic>? dropoffAddress,
    bool isExpress = false,
  }) async {
    final response = await _dio.post('/pricing/estimate', data: {
      'category': category.toString().split('.').last,
      'sub_type': subType,
      'pickup_address': pickupAddress,
      'dropoff_address': dropoffAddress,
      'is_express': isExpress,
    });
    return response.data;
  }

  Future<Errand> createErrand(Map<String, dynamic> errandData) async {
    final response = await _dio.post('/errands', data: errandData);
    return Errand.fromJson(response.data);
  }

  Future<List<Errand>> getMyErrands() async {
    final response = await _dio.get('/errands');
    return (response.data as List).map((e) => Errand.fromJson(e)).toList();
  }
}
