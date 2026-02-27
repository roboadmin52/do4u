import 'package:dio/dio.dart';
import 'package:models/models.dart';

class PaymentRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.do4u.app/v1'));

  Future<double> getWalletBalance() async {
    final response = await _dio.get('/payments/me/wallet');
    return (response.data['balance'] ?? 0.0).toDouble();
  }

  Future<double> topUpWallet(double amount) async {
    final response = await _dio.post('/payments/me/wallet/topup', data: {'amount': amount});
    return (response.data['balance'] ?? 0.0).toDouble();
  }

  Future<Map<String, dynamic>> initiatePayment(String errandId, double amount) async {
    final response = await _dio.post('/payments/initiate', data: {
      'errand_id': errandId,
      'amount': amount,
    });
    return response.data;
  }

  Future<List<WalletTransaction>> getTransactionHistory() async {
    final response = await _dio.get('/payments/me/transactions');
    return (response.data as List).map((e) => WalletTransaction.fromJson(e)).toList();
  }
}
