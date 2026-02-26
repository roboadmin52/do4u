import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final dynamic value;
  final bool isBold;
  final double fontSize;

  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? fontSize + 4 : fontSize,
            ),
          ),
          Text(
            '${value} EGP',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? fontSize + 4 : fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
