import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(WalletBalanceRequested());
    context.read<PaymentBloc>().add(TransactionHistoryRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Do4U Wallet')),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state.status == PaymentStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PaymentStatus.loading && state.transactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.teal,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const Text('Current Balance', style: TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text(
                          '${state.walletBalance.toStringAsFixed(2)} EGP',
                          style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Quick Top-up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [100.0, 200.0, 500.0].map((amount) {
                    return ElevatedButton(
                      onPressed: () => context.read<PaymentBloc>().add(WalletTopUpRequested(amount)),
                      child: Text('+$amount'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                const Text('Transaction History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                if (state.transactions.isEmpty)
                  const Text('No transactions yet.')
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.transactions.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final tx = state.transactions[index];
                      final isCredit = tx.type == 'credit';
                      return ListTile(
                        leading: Icon(isCredit ? Icons.add_circle : Icons.remove_circle, color: isCredit ? Colors.green : Colors.red),
                        title: Text(tx.description),
                        subtitle: Text(tx.createdAt.toString().split('.')[0]),
                        trailing: Text(
                          '${isCredit ? "+" : "-"}${tx.amount} EGP',
                          style: TextStyle(fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
