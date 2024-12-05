import 'package:flutter/material.dart';
import 'package:flutter_template/src/theme.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({super.key, required this.label, required this.value});

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMedium,
        ),
        Text(
          value,
          style: context.labelMedium,
        ),
      ],
    );
  }
}
