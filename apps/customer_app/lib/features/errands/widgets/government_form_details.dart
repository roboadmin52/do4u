import 'package:flutter/material.dart';

class GovernmentFormDetails extends StatelessWidget {
  final String? selectedDocType;
  final bool returnToHome;
  final ValueChanged<String?> onDocTypeChanged;
  final ValueChanged<bool> onReturnToggleChanged;

  const GovernmentFormDetails({
    super.key,
    required this.selectedDocType,
    required this.returnToHome,
    required this.onDocTypeChanged,
    required this.onReturnToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final docTypes = ['Passport', 'Visa', 'Notary', 'Bills', 'Car License', 'Other'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Document Type', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedDocType,
          items: docTypes
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onDocTypeChanged,
          decoration: const InputDecoration(hintText: 'Select document type'),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Return documents to my home?'),
          subtitle: const Text('Adds a return trip to the runner'),
          value: returnToHome,
          onChanged: onReturnToggleChanged,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
