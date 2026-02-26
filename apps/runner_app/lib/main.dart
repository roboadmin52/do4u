import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/screens/phone_input_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(context.read<AuthRepository>()),
        child: MaterialApp(
          title: 'Do4U Runner',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            useMaterial3: true,
          ),
          home: const PhoneInputScreen(),
        ),
      ),
    );
  }
}
