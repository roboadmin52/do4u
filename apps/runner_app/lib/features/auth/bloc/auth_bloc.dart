import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthState()) {
    on<AuthSendOtpRequested>(_onSendOtpRequested);
    on<AuthVerifyOtpRequested>(_onVerifyOtpRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSendOtpRequested(
    AuthSendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _repository.sendOtp(event.phone);
      emit(state.copyWith(status: AuthStatus.otpSent, phone: event.phone));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(
    AuthVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final data = await _repository.verifyOtp(event.phone, event.otp);
      final isNewUser = data['isNewUser'] as bool;

      if (isNewUser) {
        emit(state.copyWith(status: AuthStatus.needsRegistration, isNewUser: true));
      } else {
        final token = data['token'] as String;
        await _repository.saveToken(token);
        emit(state.copyWith(status: AuthStatus.authenticated));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final data = await _repository.register(
        phone: event.phone,
        fullName: event.fullName,
        email: event.email,
      );
      final token = data['token'] as String;
      await _repository.saveToken(token);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }
}
