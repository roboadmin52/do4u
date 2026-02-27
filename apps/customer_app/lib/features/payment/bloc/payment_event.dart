import 'package:models/models.dart';

abstract class PaymentEvent {}

class WalletBalanceRequested extends PaymentEvent {}

class WalletTopUpRequested extends PaymentEvent {
  final double amount;
  WalletTopUpRequested(this.amount);
}

class PaymentInitiated extends PaymentEvent {
  final String errandId;
  final double amount;
  final String method;
  PaymentInitiated({required this.errandId, required this.amount, required this.method});
}

class TransactionHistoryRequested extends PaymentEvent {}
