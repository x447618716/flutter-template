import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class Empty extends StatelessWidget {
  const Empty({super.key, this.loading = false});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty.png',
                  width: 147.r, height: 127.r),
              if (loading) SizedBox(height: 20.h),
              if (!loading)
                Text(
                  context.localization.noData,
                  style: context.bodyMedium.copyWith(
                    color: context.bodyMedium.color!.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        ),
        if (loading) const CircularProgressIndicator(),
      ],
    );
  }
}
