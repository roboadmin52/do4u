import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_event.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_state.dart';
import 'package:customer_app/features/errands/widgets/payment_method_selector.dart';

class PriceEstimateScreen extends StatefulWidget {
  const PriceEstimateScreen({super.key});

  @override
  State<PriceEstimateScreen> createState() => _PriceEstimateScreenState();
}

class _PriceEstimateScreenState extends State<PriceEstimateScreen> {
  String _selectedPaymentMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Estimate')),
      body: BlocConsumer<ErrandCreationBloc, ErrandCreationState>(
        listener: (context, state) {
          if (state.status == ErrandCreationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Errand Booked Successfully!')),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state.status == ErrandCreationStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error booking errand')),
            );
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
                        _buildPriceRow('Base Fee', estimate['baseFee']),
                        if (estimate['peakFee'] > 0) _buildPriceRow('Peak Surcharge', estimate['peakFee']),
                        if (estimate['expressFee'] > 0) _buildPriceRow('Express Surcharge', estimate['expressFee']),
                        if (estimate['distanceSurcharge'] > 0)
                          _buildPriceRow('Distance Surcharge', estimate['distanceSurcharge']),
                        const Divider(height: 24),
                        _buildPriceRow('Total', estimate['total'], isBold: true),
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
                SizedBox(
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
                        : const Text('Confirm & Book Errand', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRow(String label, dynamic value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 14,
          )),
          Text('${value} EGP', style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 14,
          )),
        ],
      ),
    );
  }
}
