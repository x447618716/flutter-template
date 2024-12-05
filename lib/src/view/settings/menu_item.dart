import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: 30.r,
        height: 30.r,
      ),
      title: Text(
        title,
        style: context.titleMedium,
      ),
      trailing: Icon(
        Icons.chevron_right_outlined,
        color: context.dividerColor,
      ),
      onTap: onTap,
    );
  }
}
