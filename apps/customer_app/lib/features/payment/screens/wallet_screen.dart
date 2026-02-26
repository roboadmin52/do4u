import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/payment_repository.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    setState(() => _isLoading = true);
    try {
      final balance = await context.read<PaymentRepository>().getWalletBalance();
      setState(() {
        _balance = balance;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _topUp(double amount) async {
    try {
      final newBalance = await context.read<PaymentRepository>().topUpWallet(amount);
      setState(() => _balance = newBalance);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Top-up of $amount EGP successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Top-up failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Do4U Wallet')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                            '${_balance.toStringAsFixed(2)} EGP',
                            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text('Quick Top-up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [100, 200, 500].map((amount) {
                      return ElevatedButton(
                        onPressed: () => _topUp(amount.toDouble()),
                        child: Text('+$amount'),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
