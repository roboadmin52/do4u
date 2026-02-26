import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import '../repository/membership_repository.dart';

class MembershipOverviewScreen extends StatefulWidget {
  const MembershipOverviewScreen({super.key});

  @override
  State<MembershipOverviewScreen> createState() => _MembershipOverviewScreenState();
}

class _MembershipOverviewScreenState extends State<MembershipOverviewScreen> {
  Membership? _membership;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMembership();
  }

  Future<void> _loadMembership() async {
    setState(() => _isLoading = true);
    final membership = await context.read<MembershipRepository>().getMyMembership();
    setState(() {
      _membership = membership;
      _isLoading = false;
    });
  }

  Future<void> _subscribe(String plan) async {
    try {
      final membership = await context.read<MembershipRepository>().subscribe(plan);
      setState(() => _membership = membership);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subscribed to $plan plan!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subscription failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memberships')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_membership != null) _buildCurrentPlan() else const Text('No active plan. Choose one below:'),
                  const SizedBox(height: 24),
                  const Text('Available Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPlanCard('Basic', '150 EGP', '6 Errands/month', 'basic'),
                  _buildPlanCard('Plus', '350 EGP', '15 Errands/month', 'plus'),
                  _buildPlanCard('Elite', '700 EGP', '35 Errands/month', 'elite'),
                ],
              ),
            ),
    );
  }

  Widget _buildCurrentPlan() {
    return Card(
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${_membership!.plan.toString().split('.').last.toUpperCase()} PLAN',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _membership!.errandsUsed / _membership!.errandsTotal,
              backgroundColor: Colors.white24,
              color: Colors.tealAccent,
            ),
            const SizedBox(height: 8),
            Text(
              '${_membership!.errandsUsed} of ${_membership!.errandsTotal} errands used',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String name, String price, String errands, String planKey) {
    return Card(
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$price | $errands'),
        trailing: ElevatedButton(
          onPressed: () => _subscribe(planKey),
          child: const Text('Choose'),
        ),
      ),
    );
  }
}
