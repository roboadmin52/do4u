import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:customer_app/features/errands/screens/category_selection_screen.dart';
import 'package:customer_app/features/payment/screens/wallet_screen.dart';
import 'package:customer_app/features/membership/screens/membership_overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Widget> _tabs = [
      const HomeTab(),
      const Center(child: Text('Errands History')),
      const MembershipOverviewScreen(),
      const Center(child: Text('Profile')),
    ];

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
          BottomNavigationBarItem(icon: const Icon(Icons.list), label: l10n.errands),
          BottomNavigationBarItem(icon: const Icon(Icons.card_membership), label: l10n.members),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.profile),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen())),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.needSomethingDone, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategorySelectionScreen()),
                );
              },
              child: Text(l10n.createNewErrand, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
