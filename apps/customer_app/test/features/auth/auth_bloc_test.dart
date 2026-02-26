import 'package:bloc_test/bloc_test.dart';
import 'package:customer_app/features/auth/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/bloc/auth_event.dart';
import 'package:customer_app/features/auth/bloc/auth_state.dart';
import 'package:customer_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    const tPhone = '+201234567890';

    blocTest<AuthBloc, AuthState>(
      'emits [loading, otpSent] when AuthSendOtpRequested is successful',
      build: () {
        when(() => mockAuthRepository.sendOtp(tPhone)).thenAnswer((_) async => {});
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendOtpRequested(tPhone)),
      expect: () => [
        predicate<AuthState>((state) => state.status == AuthStatus.loading),
        predicate<AuthState>((state) => state.status == AuthStatus.otpSent && state.phone == tPhone),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when AuthSendOtpRequested fails',
      build: () {
        when(() => mockAuthRepository.sendOtp(tPhone)).thenThrow(Exception('Failed to send OTP'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendOtpRequested(tPhone)),
      expect: () => [
        predicate<AuthState>((state) => state.status == AuthStatus.loading),
        predicate<AuthState>((state) => state.status == AuthStatus.error),
      ],
    );
  });
}
