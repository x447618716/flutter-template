import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class TraceItem extends StatelessWidget {
  const TraceItem(
      {super.key,
      required this.index,
      required this.selected,
      required this.onTap});

  final int index;
  final bool selected;
  final void Function() onTap;

  Widget _buildColorText(BuildContext context, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7).r,
        color: context.primaryColor.withOpacity(0.2),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.r,
        vertical: 7.r,
      ),
      child: Text(
        text,
        style: context.bodyMedium.copyWith(
          color: context.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(12).r,
      elevation: 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: selected
              ? Border.all(
                  color: context.primaryColor,
                  width: 1.5.r,
                )
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12).r,
          child: Stack(
            children: [
              Image.asset('assets/images/136.png'),
              Positioned(
                top: 10.r,
                left: 10.r,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7).r,
                    color: context.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.r,
                    vertical: 7.r,
                  ),
                  child: Text(
                    context.localization.traceModeName(index),
                    style: context.titleMedium.copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: context.backgroundColor,
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    children: [
                      Text(
                        context.localization.traceModeDesc(index),
                        style: context.bodyMedium,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          _buildColorText(
                            context,
                            context.localization.traceModePower(index),
                          ),
                          SizedBox(width: 5.w),
                          _buildColorText(
                            context,
                            context.localization.traceModeEndurance(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
