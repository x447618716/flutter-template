import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

class IconTextRow extends StatelessWidget {
  const IconTextRow({
    super.key,
    required this.text,
    required this.iconColor,
    required this.icon,
  });

  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: context.bodySmall,
          ),
        ),
      ],
    );
  }
}
