import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:models/models.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_event.dart';
import 'package:customer_app/features/errands/screens/errand_form_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final categories = [
      {'label': l10n.government, 'value': ErrandCategory.government, 'icon': Icons.account_balance},
      {'label': l10n.shopping, 'value': ErrandCategory.shopping, 'icon': Icons.shopping_cart},
      {'label': l10n.pickupDropoff, 'value': ErrandCategory.pickupDropoff, 'icon': Icons.local_shipping},
      {'label': l10n.queueing, 'value': ErrandCategory.queueing, 'icon': Icons.timer},
      {'label': l10n.carErrands, 'value': ErrandCategory.car, 'icon': Icons.directions_car},
      {'label': l10n.custom, 'value': ErrandCategory.custom, 'icon': Icons.dashboard_customize},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectCategory)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return InkWell(
              onTap: () {
                context.read<ErrandCreationBloc>().add(
                      ErrandCategorySelected(cat['value'] as ErrandCategory),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ErrandFormScreen()),
                );
              },
              child: Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat['icon'] as IconData, size: 48, color: Colors.teal),
                    const SizedBox(height: 8),
                    Text(
                      cat['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
