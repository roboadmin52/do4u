import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_state.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/screens/phone_input_screen.dart';
import 'features/assignment/repository/assignment_repository.dart';
import 'features/assignment/bloc/assignment_bloc.dart';
import 'features/assignment/screens/runner_home_screen.dart';

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
        RepositoryProvider(create: (context) => AssignmentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => AssignmentBloc(context.read<AssignmentRepository>())),
        ],
        child: MaterialApp(
          title: 'Do4U Runner',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                return const RunnerHomeScreen();
              }
              return const PhoneInputScreen();
            },
          ),
        ),
      ),
    );
  }
}
