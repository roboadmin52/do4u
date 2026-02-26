enum AuthStatus { initial, loading, otpSent, authenticated, unauthenticated, error, needsRegistration }

class AuthState {
  final AuthStatus status;
  final String? phone;
  final String? errorMessage;
  final bool isNewUser;

  AuthState({
    this.status = AuthStatus.initial,
    this.phone,
    this.errorMessage,
    this.isNewUser = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? phone,
    String? errorMessage,
    bool? isNewUser,
  }) {
    return AuthState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
