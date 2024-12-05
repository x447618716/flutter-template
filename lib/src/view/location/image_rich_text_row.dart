import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

class ImageRichTextRow extends StatelessWidget {
  const ImageRichTextRow({
    super.key,
    required this.image,
    required this.text,
    required this.subText,
  });

  final String image;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 20.r,
          height: 19.r,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: text,
              style: context.bodySmall,
              children: [
                const TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: subText,
                  style: context.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
