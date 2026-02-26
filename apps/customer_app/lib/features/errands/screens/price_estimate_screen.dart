import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/errand_creation_bloc.dart';
import '../bloc/errand_creation_event.dart';
import '../bloc/errand_creation_state.dart';

class PriceEstimateScreen extends StatelessWidget {
  const PriceEstimateScreen({super.key});

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
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildPriceRow('Base Fee', estimate['baseFee']),
                        if (estimate['peakFee'] > 0) _buildPriceRow('Peak Surcharge', estimate['peakFee']),
                        if (estimate['expressFee'] > 0) _buildPriceRow('Express Surcharge', estimate['expressFee']),
                        if (estimate['distanceSurcharge'] > 0)
                          _buildPriceRow('Distance Surcharge', estimate['distanceSurcharge']),
                        const Divider(),
                        _buildPriceRow('Total', estimate['total'], isBold: true),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                    onPressed: state.status == ErrandCreationStatus.submitting
                        ? null
                        : () {
                            context.read<ErrandCreationBloc>().add(ErrandSubmitRequested('cash'));
                          },
                    child: state.status == ErrandCreationStatus.submitting
                        ? const CircularProgressIndicator()
                        : const Text('Confirm & Book Errand'),
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
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('${value} EGP', style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
