import 'package:flutter/material.dart';

class CarFormDetails extends StatelessWidget {
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController plateController;

  const CarFormDetails({
    super.key,
    required this.makeController,
    required this.modelController,
    required this.plateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vehicle Details', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: makeController,
          decoration: const InputDecoration(labelText: 'Make (e.g. Toyota)'),
        ),
        TextFormField(
          controller: modelController,
          decoration: const InputDecoration(labelText: 'Model (e.g. Corolla)'),
        ),
        TextFormField(
          controller: plateController,
          decoration: const InputDecoration(labelText: 'Plate Number'),
        ),
      ],
    );
  }
}
