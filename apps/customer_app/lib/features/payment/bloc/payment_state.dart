import 'package:models/models.dart';

enum PaymentStatus { initial, loading, success, error }

class PaymentState {
  final PaymentStatus status;
  final double walletBalance;
  final List<WalletTransaction> transactions;
  final String? checkoutUrl;
  final String? errorMessage;

  PaymentState({
    this.status = PaymentStatus.initial,
    this.walletBalance = 0.0,
    this.transactions = const [],
    this.checkoutUrl,
    this.errorMessage,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    double? walletBalance,
    List<WalletTransaction>? transactions,
    String? checkoutUrl,
    String? errorMessage,
  }) {
    return PaymentState(
      status: status ?? this.status,
      walletBalance: walletBalance ?? this.walletBalance,
      transactions: transactions ?? this.transactions,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
