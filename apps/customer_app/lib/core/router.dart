import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/features/auth/screens/phone_input_screen.dart';
import 'package:customer_app/features/home/home_screen.dart';
import 'package:customer_app/features/errands/screens/category_selection_screen.dart';
import 'package:models/models.dart';
import 'package:customer_app/features/errands/screens/errand_form_screen.dart';
import 'package:customer_app/features/errands/screens/price_estimate_screen.dart';
import 'package:customer_app/features/errands/screens/errand_tracking_screen.dart';
import 'package:customer_app/features/payment/screens/wallet_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PhoneInputScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/create-errand',
      builder: (context, state) => const CategorySelectionScreen(),
      routes: [
        GoRoute(
          path: 'form',
          builder: (context, state) => const ErrandFormScreen(),
        ),
        GoRoute(
          path: 'estimate',
          builder: (context, state) => const PriceEstimateScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/errands/:id',
      builder: (context, state) => ErrandTrackingScreen(errand: state.extra as Errand),
    ),
  ],
);
