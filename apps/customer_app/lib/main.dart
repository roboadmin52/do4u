import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/screens/phone_input_screen.dart';
import 'features/errands/bloc/errand_creation_bloc.dart';
import 'features/errands/repository/errand_repository.dart';
import 'features/home/home_screen.dart';

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
