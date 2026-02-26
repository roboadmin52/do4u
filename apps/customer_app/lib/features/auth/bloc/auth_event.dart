abstract class AuthEvent {}

class AuthSendOtpRequested extends AuthEvent {
  final String phone;
  AuthSendOtpRequested(this.phone);
}

class AuthVerifyOtpRequested extends AuthEvent {
  final String phone;
  final String otp;
  AuthVerifyOtpRequested(this.phone, this.otp);
}

class AuthRegisterRequested extends AuthEvent {
  final String phone;
  final String fullName;
  final String? email;
  AuthRegisterRequested({
    required this.phone,
    required this.fullName,
    this.email,
  });
}

class AuthLogoutRequested extends AuthEvent {}
