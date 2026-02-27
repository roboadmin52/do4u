import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  PaymentBloc(this._repository) : super(PaymentState()) {
    on<WalletBalanceRequested>(_onBalanceRequested);
    on<WalletTopUpRequested>(_onTopUpRequested);
    on<PaymentInitiated>(_onPaymentInitiated);
    on<TransactionHistoryRequested>(_onHistoryRequested);
  }

  Future<void> _onHistoryRequested(
    TransactionHistoryRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      final transactions = await _repository.getTransactionHistory();
      emit(state.copyWith(status: PaymentStatus.success, transactions: transactions));
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onBalanceRequested(
    WalletBalanceRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      final balance = await _repository.getWalletBalance();
      emit(state.copyWith(status: PaymentStatus.success, walletBalance: balance));
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onTopUpRequested(
    WalletTopUpRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      final balance = await _repository.topUpWallet(event.amount);
      emit(state.copyWith(status: PaymentStatus.success, walletBalance: balance));
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onPaymentInitiated(
    PaymentInitiated event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      if (event.method == 'card') {
        final data = await _repository.initiatePayment(event.errandId, event.amount);
        emit(state.copyWith(status: PaymentStatus.success, checkoutUrl: data['payment_url']));
      } else {
        // Wallet handled via Errand submit for now or separate call
        emit(state.copyWith(status: PaymentStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.error, errorMessage: e.toString()));
    }
  }
}
