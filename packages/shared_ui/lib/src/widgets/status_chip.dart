import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;
  final Map<String, Color> colorMap;

  const StatusChip({
    super.key,
    required this.status,
    this.colorMap = const {
      'draft': Colors.grey,
      'pending_payment': Colors.orange,
      'confirmed': Colors.teal,
      'completed': Colors.green,
      'cancelled': Colors.red,
    },
  });

  @override
  Widget build(BuildContext context) {
    final color = colorMap[status.toLowerCase()] ?? Colors.teal;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
