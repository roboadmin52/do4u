import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import '../bloc/membership_bloc.dart';
import '../bloc/membership_event.dart';
import '../bloc/membership_state.dart';

class MembershipOverviewScreen extends StatefulWidget {
  const MembershipOverviewScreen({super.key});

  @override
  State<MembershipOverviewScreen> createState() => _MembershipOverviewScreenState();
}

class _MembershipOverviewScreenState extends State<MembershipOverviewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MembershipBloc>().add(MembershipRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memberships')),
      body: BlocConsumer<MembershipBloc, MembershipState>(
        listener: (context, state) {
          if (state.status == MembershipStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == MembershipStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.membership != null)
                  _buildCurrentPlan(state.membership!)
                else
                  const Text('No active plan. Choose one below:'),
                const SizedBox(height: 24),
                const Text('Available Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildPlanCard('Basic', '150 EGP', '6 Errands/month', 'basic'),
                _buildPlanCard('Plus', '350 EGP', '15 Errands/month', 'plus'),
                _buildPlanCard('Elite', '700 EGP', '35 Errands/month', 'elite'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentPlan(Membership membership) {
    return Card(
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${membership.plan.toString().split('.').last.toUpperCase()} PLAN',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: membership.errandsUsed / membership.errandsTotal,
              backgroundColor: Colors.white24,
              color: Colors.tealAccent,
            ),
            const SizedBox(height: 8),
            Text(
              '${membership.errandsUsed} of ${membership.errandsTotal} errands used',
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
          onPressed: () => context.read<MembershipBloc>().add(MembershipSubscribeRequested(planKey)),
          child: const Text('Choose'),
        ),
      ),
    );
  }
}
