import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:customer_app/core/router.dart' as core;
import 'package:customer_app/features/auth/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/repository/auth_repository.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/repository/errand_repository.dart';
import 'package:customer_app/features/payment/repository/payment_repository.dart';
import 'package:customer_app/features/payment/bloc/payment_bloc.dart';
import 'package:customer_app/features/membership/repository/membership_repository.dart';
import 'package:customer_app/features/membership/bloc/membership_bloc.dart';
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
          BlocProvider(create: (context) => PaymentBloc(context.read<PaymentRepository>())),
          BlocProvider(create: (context) => MembershipBloc(context.read<MembershipRepository>())),
          BlocProvider(
            create: (context) => ErrandCreationBloc(
              context.read<ErrandRepository>(),
              context.read<PaymentBloc>(),
            ),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              core.router.go('/home');
            } else if (state.status == AuthStatus.unauthenticated) {
              core.router.go('/');
            }
          },
          child: MaterialApp.router(
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
            routerConfig: core.router,
          ),
        ),
      ),
    );
  }
}
