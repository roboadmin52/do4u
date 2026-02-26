import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:customer_app/features/auth/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/repository/auth_repository.dart';
import 'package:customer_app/features/auth/screens/phone_input_screen.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/repository/errand_repository.dart';
import 'package:customer_app/features/payment/repository/payment_repository.dart';
import 'package:customer_app/features/membership/repository/membership_repository.dart';
import 'package:customer_app/features/home/home_screen.dart';
import 'package:customer_app/features/auth/bloc/auth_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => ErrandRepository()),
        RepositoryProvider(create: (context) => PaymentRepository()),
        RepositoryProvider(create: (context) => MembershipRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => ErrandCreationBloc(context.read<ErrandRepository>())),
        ],
        child: MaterialApp(
          title: 'Do4U',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          locale: const Locale('en'), // Default to English for now, would be dynamic
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                return const HomeScreen();
              }
              return const PhoneInputScreen();
            },
          ),
        ),
      ),
    );
  }
}
