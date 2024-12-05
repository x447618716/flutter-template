import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.image,
    required this.title,
    required this.imageSize,
    this.onPressed,
  });

  final String image;
  final String title;
  final Size imageSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(12).r,
      elevation: 1.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(24.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12).r,
          ),
        ),
        child: Column(
          children: [
            Image.asset(image,
                width: imageSize.width, height: imageSize.height),
            SizedBox(height: 10.h),
            Text(
              title,
              style: context.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
