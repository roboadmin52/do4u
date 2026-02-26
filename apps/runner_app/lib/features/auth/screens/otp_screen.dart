import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'profile_setup_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigate to Home
          } else if (state.status == AuthStatus.needsRegistration) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileSetupScreen(phone: widget.phone),
              ),
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OTP sent to ${widget.phone}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _start > 0 ? 'Resend OTP in $_start seconds' : 'You can now resend OTP',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  AuthVerifyOtpRequested(widget.phone, _otpController.text),
                                );
                          },
                    child: state.status == AuthStatus.loading
                        ? const CircularProgressIndicator()
                        : const Text('Verify'),
                  ),
                ),
                if (_start == 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _start = 60;
                        startTimer();
                      });
                      context.read<AuthBloc>().add(AuthSendOtpRequested(widget.phone));
                    },
                    child: const Text('Resend OTP'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
