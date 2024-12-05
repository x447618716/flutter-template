import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/spinning_icon_button.dart';
import 'package:flutter_template/src/theme.dart';

class RefreshTimer extends StatefulWidget {
  const RefreshTimer({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  State<RefreshTimer> createState() => _RefreshTimerState();
}

class _RefreshTimerState extends State<RefreshTimer> with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _count = 9;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_count > 0) {
        _setCount(_count - 1);
        return;
      }
      await _refresh();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _setCount(int count) {
    if (mounted) {
      setState(() {
        _count = count;
      });
    }
  }

  Future<void> _refresh() async {
    _animationController.repeat();
    await widget.onRefresh();
    _setCount(9);
    _animationController.stop();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(15).r,
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_count}s',
              style: context.bodySmall.copyWith(
                color: context.primaryColor,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            SpinningIconButton(
              onPressed: () async {
                await _refresh();
              },
              icon: Icons.refresh,
              controller: _animationController,
              color: context.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
