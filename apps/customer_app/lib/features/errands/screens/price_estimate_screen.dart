import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_event.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_state.dart';
import 'package:customer_app/features/errands/widgets/payment_method_selector.dart';
import 'package:customer_app/features/payment/bloc/payment_bloc.dart';
import 'package:customer_app/features/payment/bloc/payment_event.dart';
import 'package:customer_app/features/payment/bloc/payment_state.dart' as p;
import 'package:shared_ui/shared_ui.dart';

class PriceEstimateScreen extends StatefulWidget {
  const PriceEstimateScreen({super.key});

  @override
  State<PriceEstimateScreen> createState() => _PriceEstimateScreenState();
}

class _PriceEstimateScreenState extends State<PriceEstimateScreen> {
  String _selectedPaymentMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.priceEstimate)),
      body: BlocConsumer<ErrandCreationBloc, ErrandCreationState>(
        listener: (context, state) {
          if (state.status == ErrandCreationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Errand Booked Successfully!')),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (state.status == ErrandCreationStatus.estimating) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.priceEstimate == null) {
            return const Center(child: Text('Failed to load estimate'));
          }

          final estimate = state.priceEstimate!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        PriceRow(label: l10n.baseFee, value: estimate['baseFee']),
                        if (estimate['peakFee'] > 0) PriceRow(label: l10n.peakSurcharge, value: estimate['peakFee']),
                        if (estimate['expressFee'] > 0) PriceRow(label: l10n.expressSurcharge, value: estimate['expressFee']),
                        if (estimate['distanceSurcharge'] > 0)
                          PriceRow(label: l10n.distanceSurcharge, value: estimate['distanceSurcharge']),
                        const Divider(height: 24),
                        PriceRow(label: l10n.total, value: estimate['total'], isBold: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                PaymentMethodSelector(
                  selectedMethod: _selectedPaymentMethod,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedPaymentMethod = val);
                  },
                ),
                const Spacer(),
                BlocListener<PaymentBloc, p.PaymentState>(
                  listener: (context, pState) {
                    if (pState.checkoutUrl != null) {
                      // In real app, launch WebView or url_launcher
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Redirecting to: ${pState.checkoutUrl}')),
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: state.status == ErrandCreationStatus.submitting
                          ? null
                          : () {
                              context.read<ErrandCreationBloc>().add(
                                    ErrandSubmitRequested(_selectedPaymentMethod),
                                  );
                            },
                      child: state.status == ErrandCreationStatus.submitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(l10n.confirmBook, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
